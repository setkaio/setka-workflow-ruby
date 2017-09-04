module Setka
  module Workflow
    class Category < Resource
      # Methods set to work with çategories
      class << self
        # Creates a category.
        #
        # @param [Hash] body Attributes of a new category.
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @raise  [Workflow::Category] If something went wrong during category's
        #     creation.
        #
        # @return [Hash] Hash of category's attibutes.
        def create(body, options = {})
          collection(:post, nil, body, options)
        end

        # Updates a category.
        # @param [Integer] id Category's id
        #
        # @param [Hash] body Category's attributes to update.
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @raise  [Workflow::Category] If something went wrong during category's
        #     updating.
        #
        # @return [Hash] Hash of category's attibutes.
        def update(id, body, options = {})
          member(:patch, id, nil, body, options)
        end

        # Deletes a category.
        # @param [Integer] id Category's id
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @raise  [Workflow::Category] If something went wrong during category's
        #     deleting.
        #
        # @return [Hash] Hash of category's attibutes.
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
end
