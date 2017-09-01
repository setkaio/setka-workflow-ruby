require 'spec_helper'

describe Workflow::Category do
  let(:space_name) { 'somespace' }

  before do
    Workflow.configure do |c|
      c.access_token = 'sometoken'
      c.space_name = space_name
    end
  end

  describe '.create' do
    let(:body) { { name: 'Some category' } }
    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}/categories.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:post, url).with(body: body.to_json)
      Workflow::Category.create(body)
    end
  end

  describe '.delete' do
    let(:id) { rand(1000) }
    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}/categories/#{id}.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:delete, url).with(body: nil)
      Workflow::Category.delete(id)
    end
  end

  describe '.update' do
    let(:id) { rand(1000) }
    let(:body) { { name: 'Yet another category' } }
    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}/categories/#{id}.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:patch, url).with(body: body.to_json)
      Workflow::Category.update(id, body)
    end
  end
end
