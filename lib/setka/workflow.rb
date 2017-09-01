require 'setka/workflow/version'

module Setka
  module Workflow
    autoload :Client,            'setka/workflow/client'
    autoload :Request,           'setka/workflow/request'
    autoload :Response,          'setka/workflow/response'
    autoload :Configuration,     'setka/workflow/configuration'
    autoload :Resource,          'setka/workflow/resource'
    autoload :Ticket,            'setka/workflow/ticket'
    autoload :Category,          'setka/workflow/category'

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
      @client ||= Setka::Workflow::Client.new
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
end
