require 'setka/workflow/version'

# Ruby implementations of Setka Workflow API for integration an external
# publishing platform written in the Ruby language with Setka Workflow.
#
# First of all access token should be obtained. It can be acomplished on
# Integration page of Settings
# (https://workflow.setka.io/spacename/settings/api
# where spacename is name of your space).

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

    # Current default version of API
    API_VERSION = 3

    # Basic Workflow error
    Error = Class.new(StandardError)

    # This error is thrown when your client has not been configured
    ConfigurationError = Class.new(Error)

    # This error is thrown when format of the param is wrong
    WrongParamError = Class.new(Error)

    # This error is thrown when access token is invalid
    InvalidAccessToken = Class.new(Error)

    # This error is thrown when Setka Workflow responds with 500
    InternalServerError = Class.new(Error)

    # Clears current client
    def self.reset!
      @client = nil
    end

    # Gets current client
    def self.client
      @client ||= Setka::Workflow::Client.new
    end

    # Workflow client configuration in the global manner
    def self.configure(&block)
      reset!
      client.configure(&block)
    end

    def self.logger
      @logger ||= Logger.new(STDOUT)
    end

    # Sets custom logger
    def self.logger=(logger)
      @logger = logger
    end
  end
end
