module Setka
  module Workflow
    class Ticket < Resource
      class << self
        def publish(id, options = {})
          member(:patch, id, :publish, nil, options)
        end

        def unpublish(id, options = {})
          member(:patch, id, :unpublish, nil, options)
        end

        def update(id, body, options = {})
          member(:patch, id, nil, body, options)
        end

        def sync_analytics(body, options = {})
          collection(:patch, :sync_analytics, body, options)
        end

        private

        def resource_plural
          :tickets
        end
      end
    end
  end
end
