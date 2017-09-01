require 'workflow/version'

module Workflow
  autoload :Client,            'workflow/client'
  autoload :Request,           'workflow/request'
  autoload :Response,          'workflow/response'
  autoload :Configuration,     'workflow/configuration'
  autoload :Resource,          'workflow/resource'
  autoload :Ticket,            'workflow/ticket'
  autoload :Category,          'workflow/category'

  BASE_ENDPOINT = 'workflow.setka.io'.freeze
  API_VERSION = 3

  Error = Class.new(StandardError)
  ConfigurationError = Class.new(Error)
  WrongParamError = Class.new(Error)
  InvalidAccessToken = Class.new(Error)
  InternalServerError = Class.new(Error)

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
