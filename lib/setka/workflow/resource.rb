module Setka
  module Workflow
    class Resource
      class << self
        def member(http_verb, id, action = nil, body = nil, options)
          actual_client(options).send(http_verb, path(action, id), body, options)
        end

        def collection(http_verb, action = nil, body = nil, options)
          actual_client(options).send(http_verb, path(action), body, options)
        end

        def actual_client(options)
          if options[:client]
            raise ConfigurationError.new('Wrong client is specified') unless
              options[:client].is_a?(Setka::Workflow::Client)

            options[:client]
          else
            Setka::Workflow.client
          end
        end

        private

        def path(action, id = nil)
          id_clause = "/#{id}" if id
          action_clause = "/#{action}" if action

          "#{resource_plural}#{id_clause}#{action_clause}.json"
        end

        def resource_plural; end
      end
    end
  end
end
