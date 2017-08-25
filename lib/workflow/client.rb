require 'forwardable'

module Workflow
  class Client
    extend Forwardable

    def_delegators :configuration, :credentials,
      *Configuration.configurable_attributes

    def initialize(attrs = {})
      self.configuration.attributes = attrs
    end

    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
