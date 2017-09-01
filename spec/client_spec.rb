require 'spec_helper'

describe Workflow::Client do
  context 'initialize' do
    let(:client) do
      Workflow::Client.new(
        access_token: 'some_access_token',
        space_name: 'some_space_name'
      )
    end

    it 'is configurable' do
      expect(client.access_token).to eq('some_access_token')
      expect(client.space_name).to eq('some_space_name')
    end

    describe '#configure' do
      it "sets key attributes through config block" do
        client.configure do |config|
          config.access_token = 'yet_another_access_token'
          config.space_name = 'yet_another_space_name'
        end

        expect(client.access_token).to eq('yet_another_access_token')
        expect(client.space_name).to eq('yet_another_space_name')
      end
    end

    [:access_token, :space_name].each do |attribute|
      it "delegates a #{attribute} attribute setting" do
        client.public_send(:"#{attribute}=", attribute.to_s)
        expect(client.public_send(attribute.to_s)).to eq attribute.to_s
      end
    end
  end

  context 'requesting' do
    [:post, :patch, :delete ].each do |verb|
      describe "##{verb}" do
        let(:body) { { attribute: "value for #{verb}" } }
        let(:options) { { option: "value for #{verb}" } }
        let(:path) { "some/path/#{verb}" }

        let(:valid_client) do
          Workflow::Client.new(
            access_token: 'some_access_token',
            space_name: 'some_space_name'
          )
        end

        let(:invalid_client) do
          Workflow::Client.new(access_token: 'some_access_token')
        end

        it 'executes #invoke_verb with appropriate arguments' do
          expected_options = options.merge(
              headers: { authorization: "token some_access_token" }
            )

          expected_path = URI::HTTPS.build(
            host: 'workflow.setka.io',
            path: "/eapi/v3/some_space_name/#{path}"
          )

          expect(valid_client).to receive(:invoke_verb).with(
            verb, expected_path, body, expected_options
          )

          valid_client.public_send(verb, path, body, options)
        end

        it 'raises specific error if credentials are not specified completely' do
          expect do
            invalid_client.public_send(verb, path, body, options)
          end.to raise_error(
            Workflow::ConfigurationError, 'space_name is not specified'
          )
        end

        it 'returns body if request has been succesful' do
          request = double(:request)
          allow(Workflow::Request).to receive(:new).and_return(request)

          response = double(
            :response, code: '200', body: { ticket: 'Ticket object' }
          )

          allow(request).to receive(:execute).and_return(response)

          result_response = valid_client.public_send(verb, path, body, options)

          expect(result_response).to eq(response.body)
        end

        context 'when expection has been thrown' do
          let(:request) { double(:request) }

          before do
            allow(Workflow::Request).to receive(:new).and_return(request)
          end

          it 'raises specific error if response code is 401' do
            response = double(
              :response, code: '401', body: { message: 'Token is invalid' }
            )

            allow(request).to receive(:execute).and_return(response)

            expect do
              valid_client.public_send(verb, path, body, options)
            end.to raise_error(
              Workflow::InvalidAccessToken, 'Token is invalid'
            )
          end

          it 'raises specific error if response code is 500' do
            response = double(
              :response, code: '500', body: { message: 'Internal server error' }
            )

            allow(request).to receive(:execute).and_return(response)

            expect do
              valid_client.public_send(verb, path, body, options)
            end.to raise_error(
              Workflow::InternalServerError, 'Internal server error'
            )
          end

          it 'raises specific error if response code is not 200 or 201' do
            response = double(
              :response, code: '400', body: 'Bad request'
            )

            allow(request).to receive(:execute).and_return(response)

            expect do
              valid_client.public_send(verb, path, body, options)
            end.to raise_error(
              Workflow::Error, 'Bad request'
            )
          end
        end
      end
    end
  end
end
