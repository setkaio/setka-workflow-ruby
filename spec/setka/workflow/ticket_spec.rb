require 'spec_helper'

describe Setka::Workflow::Ticket do
  let(:space_name) { 'somespace' }

  before do
    Setka::Workflow.configure do |c|
      c.access_token = 'sometoken'
      c.space_name = space_name
    end
  end

  describe '.publish' do
    let(:id) { rand(1000) }
    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}"\
      "/tickets/#{id}/publish.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:patch, url).with(body: nil)
      Setka::Workflow::Ticket.publish(id)
    end
  end

  describe '.unpublish' do
    let(:id) { rand(1000) }
    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}"\
      "/tickets/#{id}/unpublish.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:patch, url).with(body: nil)
      Setka::Workflow::Ticket.unpublish(id)
    end
  end

  describe '.update' do
    let(:id) { rand(1000) }
    let(:body) do
      {
        title: 'Yet another ticket',
        category_id: rand(1000),
        view_post_url: 'http://someurl',
        views_count: rand(1000)
      }
    end

    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}/tickets/#{id}.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:patch, url).with(body: body.to_json)
      Setka::Workflow::Ticket.update(id, body)
    end
  end

  describe '.sync_analytics' do
    let(:body) do
      {
        tickets: ['ticket1', 'ticket2', 'ticket3']
      }
    end

    let(:url) do
      "https://workflow.setka.io/eapi/v3/#{space_name}"\
      "/tickets/sync_analytics.json"
    end

    it 'send request with appropriate params and verb' do
      stub_request(:patch, url).with(body: body.to_json)
      Setka::Workflow::Ticket.sync_analytics(body)
    end
  end
end
