require 'spec_helper'

describe Setka::Workflow::Resource do
  let(:http_verb) { :post }
  let(:action) { :getbetter }
  let(:body) { { some_key: 'some_value' } }
  let(:options) { { some_option_key: 'some_option_value' } }
  let(:options_with_client) do
    {
      some_option_key: 'some_option_value',
      client: Setka::Workflow::Client.new
    }
  end
  let(:options_with_fake_client) do
    { some_option_key: 'some_option_value', client: double(:custom_client) }
  end

  let(:client) { double(:client) }

  describe '.member' do
    let(:id) { rand(1000) }

    context 'when action param has been passed' do
      it 'executes appropriate verb method with params' do
        allow(Setka::Workflow).to receive(:client).and_return(client)

        expected_path = "/#{id}/#{action}.json"

        expect(client).to receive(http_verb).with(expected_path, body, options)

        Setka::Workflow::Resource.member(http_verb, id, action, body, options)
      end
    end

    context 'when action param has not been passed' do
      it 'executes appropriate verb method with params' do
        allow(Setka::Workflow).to receive(:client).and_return(client)

        expected_path = "/#{id}.json"

        expect(client).to receive(http_verb).with(expected_path, body, options)

        Setka::Workflow::Resource.member(http_verb, id, nil, body, options)
      end
    end

    context 'when custom client has been passed' do
      it 'raises specific error if client is invalid' do
        expect {
          Setka::Workflow::Resource.member(
            http_verb, id, nil, body, options_with_fake_client
          )
        }.to raise_error(
          Setka::Workflow::ConfigurationError, 'Wrong client is specified'
        )
      end

      it 'executes appropriate verb method with params on custom client' do
        expect(options_with_client[:client]).to receive(http_verb)

        Setka::Workflow::Resource.member(
          http_verb, id, nil, body, options_with_client
        )
      end
    end
  end

  describe '.collection' do
    context 'when action param has been passed' do
      before { allow(Setka::Workflow).to receive(:client).and_return(client) }

      it 'executes appropriate verb method with params' do
        expected_path = "/#{action}.json"

        expect(client).to receive(http_verb).with(expected_path, body, options)

        Setka::Workflow::Resource.collection(http_verb, action, body, options)
      end
    end

    context 'when action param has not been passed' do
      before { allow(Setka::Workflow).to receive(:client).and_return(client) }

      it 'executes appropriate verb method with params' do
        expected_path = ".json"

        expect(client).to receive(http_verb).with(expected_path, body, options)

        Setka::Workflow::Resource.collection(http_verb, nil, body, options)
      end
    end

    context 'when custom client has been passed' do
      it 'raises specific error if client is invalid' do
        expect {
          Setka::Workflow::Resource.collection(
            http_verb, nil, body, options_with_fake_client
          )
        }.to raise_error(
        Setka::Workflow::ConfigurationError, 'Wrong client is specified'
        )
      end

      it 'executes appropriate verb method with params on custom client' do
        expect(options_with_client[:client]).to receive(http_verb)

        Setka::Workflow::Resource.collection(
          http_verb, nil, body, options_with_client
        )
      end
    end
  end
end
