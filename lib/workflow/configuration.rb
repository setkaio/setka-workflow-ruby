module Workflow
  class Configuration
    CONFIGURABLE_ATTRIBUTES = [
      :access_token,
      :space_name
    ]

    attr_accessor *CONFIGURABLE_ATTRIBUTES

    def self.configurable_attributes
      CONFIGURABLE_ATTRIBUTES
    end

    def initialize(attrs = {})
      self.attributes = attrs
    end

    def attributes=(attrs = {})
      attrs.each do |key, value|
        if CONFIGURABLE_ATTRIBUTES.include?(key)
          instance_variable_set("@#{key}", value)
        end
      end
    end

    def credentials
      { access_token: access_token }
    end
  end
end
