require 'spec_helper'

describe Setka::Workflow do
  it 'has a version number' do
    expect(Setka::Workflow::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'configures credentials' do
      Setka::Workflow.configure do |c|
        c.access_token = 'some_access_token'
        c.space_name = 'some_space_name'
      end

      expect(Setka::Workflow.client.access_token).to eq('some_access_token')
      expect(Setka::Workflow.client.space_name).to eq('some_space_name')
    end
  end

  describe '.reset!' do
    it 'resets client' do
      old_client = Setka::Workflow.client
      Setka::Workflow.reset!

      expect(Setka::Workflow.client).to_not eq(old_client)
    end
  end

  describe '.logger=' do
    it 'assignes logger' do
      logger = Logger.new(STDOUT)

      Setka::Workflow.logger = logger

      expect(Setka::Workflow.logger).to eq(logger)
    end
  end
end
