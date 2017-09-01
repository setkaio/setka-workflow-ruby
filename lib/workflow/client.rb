require 'forwardable'
require 'logger'

module Workflow
  class Client
    extend Forwardable

    def_delegators :configuration, :credentials,
      *Configuration.configurable_attributes,
      *(Configuration.configurable_attributes.map { |attr| "#{attr}=" })

    def initialize(attrs = {})
      self.configuration.attributes = attrs
    end

    def post(path, body, options)
      invoke_verb(:post, uri(path), body, with_auth(options))
    end

    def patch(path, body = nil, options)
      invoke_verb(:patch, uri(path), body, with_auth(options))
    end

    def delete(path, body = nil, options)
      invoke_verb(:delete, uri(path), body, with_auth(options))
    end

    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    private

    def invoke_verb(name, uri, body, options)
      configuration.credentials?

      request = Request.new(name, uri, body, options)
      response = request.execute

      return '' unless response

      if response.code.to_i == 401
        Workflow.logger.error("[401 #{name.to_s.upcase} #{uri}]: "\
          "#{response.body['message']}.")

        raise InvalidAccessToken, response.body[:message]
      end

      if response.code.to_i == 500
        Workflow.logger.error("[500 #{name.to_s.upcase} #{uri}]: "\
          "#{response.body['message']}.")

        raise InternalServerError, response.body[:message]
      end

      unless [200, 201].include? response.code.to_i
        Workflow.logger.error("[#{response.code} #{name.to_s.upcase} #{uri}]: "\
          "#{response.body['message']}.")

        raise Error, response.body
      end

      response.body
    end

    def uri(path)
      URI::HTTPS.build(
        host: BASE_ENDPOINT,
        path: "/eapi/v#{API_VERSION}/#{space_name}/#{path}"
      )
    end

    def with_auth(options)
      options.merge(headers: { authorization: "token #{access_token}" })
    end
  end
end
