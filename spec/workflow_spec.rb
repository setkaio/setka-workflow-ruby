require 'spec_helper'

include Workflow

describe Workflow do
  it 'has a version number' do
    expect(Workflow::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'configures credentials' do
      Workflow.configure do |c|
        c.access_token = 'some_access_token'
        c.space_name = 'some_space_name'
      end

      expect(Workflow.client.access_token).to eq('some_access_token')
      expect(Workflow.client.space_name).to eq('some_space_name')
    end
  end

  describe '.reset!' do
    it 'resets client' do
      old_client = Workflow.client
      Workflow.reset!

      expect(Workflow.client).to_not eq(old_client)
    end
  end

  describe '.logger=' do
    it 'assignes logger' do
      logger = Logger.new(STDOUT)

      Workflow.logger = logger

      expect(Workflow.logger).to eq(logger)
    end
  end
end
