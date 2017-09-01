module Workflow
  class Category < Resource
    class << self
      def create(body, options = {})
        collection(:post, nil, body, options)
      end

      def update(id, body, options = {})
        member(:patch, id, nil, body, options)
      end

      def delete(id, options = {})
        member(:delete, id, nil, nil, options)
      end

      private

      def resource_plural
        :categories
      end
    end
  end
end
