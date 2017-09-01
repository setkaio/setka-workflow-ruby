module Workflow
  class Configuration
    CONFIGURABLE_ATTRIBUTES = [
      :access_token,
      :space_name
    ]

    attr_reader *CONFIGURABLE_ATTRIBUTES

    def self.configurable_attributes
      CONFIGURABLE_ATTRIBUTES
    end

    def initialize(attrs = {})
      self.attributes = attrs
    end

    def attributes=(attrs = {})
      attrs.each do |key, value|
        if CONFIGURABLE_ATTRIBUTES.include?(key)
          validate_string_value(key, value)

          instance_variable_set("@#{key}", value)
        end
      end
    end

    def access_token=(value)
      validate_string_value(:access_token, value)

      @access_token = value
    end

    def space_name=(value)
      validate_string_value(:space_name, value)

      @space_name = value
    end

    def credentials
      { access_token: access_token, space_name: space_name }
    end

    def credentials?
      validate_credentials_presence
    end

    private

    def validate_credentials_presence
      unless credentials.values.all?
        message = credentials.select {|_, v| v.nil? }
          .map {|k, _| "#{k} is not specified"}
          .join(', ')

        raise ConfigurationError.new(message)
      end
    end

    def validate_string_value(key, value)
      raise ConfigurationError.new("#{key} must be a filled string") unless
        value.is_a?(String) && value.length > 0
    end
  end
end
