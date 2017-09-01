require 'faraday'
require 'faraday_middleware'

module Setka
  module Workflow
    class Request
      def initialize(http_verb, uri, body, options)
        @http_verb = http_verb
        @uri = uri

        if body
          raise WrongParamError.new('Body param must be a hash') unless
            body.is_a?(Hash)

          @body = body
        end

        @options = options
      end

      def execute
        Response.new(execute_core)
      end

      private

      def execute_core
        connection.send @http_verb, @uri.path do |req|
          req.body = @body if @body && @body.any?
          req.headers.update @options[:headers] if @options[:headers]
        end
      end

      def connection
        Faraday.new do |conn|
          conn.request  :json
          conn.response :json, content_type: /\bjson$/

          conn.adapter  Faraday.default_adapter
          conn.url_prefix = "#{@uri.scheme}://#{@uri.host}"
        end
      end
    end
  end
end
