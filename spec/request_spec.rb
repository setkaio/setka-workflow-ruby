require 'spec_helper'

describe Workflow::Request do
  describe 'initialize' do
    it 'raises specific error if passed body has wrong format' do
      body = double(:invalid_body)

      expect { Workflow::Request.new(:post, 'uri', body, {}) }.to raise_error(
        Workflow::WrongParamError, 'Body param must be a hash'
      )
    end
  end

  describe '.execute' do
    let(:host) { 'workflow.setka.io' }

    let(:patch_uri) do
      URI::HTTPS.build(
        host: host,
        path: '/eapi/v3/mockspace/resources/57653/someaction.json'
      )
    end

    let(:post_uri) do
      URI::HTTPS.build(
        host: host,
        path: '/eapi/v3/mockspace/resources/yetanotheraction.json'
      )
    end

    let(:delete_uri) do
      URI::HTTPS.build(
        host: host,
        path: '/eapi/v3/mockspace/resources/55112/andagain.json'
      )
    end

    [:patch, :post, :delete].each do |verb|
      context verb.to_s.upcase do
        it 'returns valid Response object' do
          body = "Successful #{verb.to_s.upcase}"
          headers = { 'Content-Length' => 3 }
          processed_headers = Hash[
              [headers.keys.map(&:downcase) + headers.values.map(&:to_s)]
            ]

          stub_request(verb, send("#{verb}_uri").to_s).to_return(
            status: 200,
            body: body,
            headers: headers
          )

          result = Workflow::Request.new(verb, send("#{verb}_uri"), {}, {})
            .execute

          expect(result).to be_instance_of Workflow::Response
          expect(result.code).to eq(200)
          expect(result.body).to eq(body)
          expect(result.headers).to eq(processed_headers)
        end

        it 'sends request with appropriate params' do
          uri = send("#{verb}_uri")
          body = { message: "Successful #{verb.to_s.upcase}" }
          options = {
            headers: {
              'Content-Length' => '124',
              'X-Some-Header' => 'Some value'
            }
          }

          headers = {
            'Content-Type' => 'application/json',
          }.merge(options[:headers])

          stub_request(verb, send("#{verb}_uri").to_s).with(
            body: body.to_json, headers: headers
          )

          Workflow::Request.new(verb, uri, body, options)
            .execute
        end
      end
    end
  end
end
