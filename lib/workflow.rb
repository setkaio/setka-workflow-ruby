require 'workflow/version'

module Workflow
  autoload :Client,            'workflow/client'
  autoload :Configuration,     'workflow/configuration'

  API_VERSION = 3

  def self.reset!
    @client = nil
  end

  def self.client
    @client ||= Workflow::Client.new
  end

  def self.configure(&block)
    reset!
    client.configure(&block)
  end

  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end
end
