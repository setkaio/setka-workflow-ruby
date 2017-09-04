module Setka
  module Workflow
    class Ticket < Resource
      # Methods set to work with tickets
      class << self
        # Publishes a ticket.
        #
        # @param [Integer] id Ticket's id.
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @raise  [Workflow::Ticket] if a ticket with the given ID could not be found,
        #     if the ticket is already published.
        #
        # @return [Hash] Hash of ticket's attibutes.
        def publish(id, options = {})
          member(:patch, id, :publish, nil, options)
        end

        # Unpublishes a ticket.
        #
        # @param [Integer] id Ticket's id.
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @raise  [Workflow::Ticket] if a ticket with the given ID could not be found,
        #     if the ticket is already unpublished.
        #
        # @return [Hash] Hash of ticket's attibutes.
        def unpublish(id, options = {})
          member(:patch, id, :unpublish, nil, options)
        end

        # Updates a ticket.
        #
        # @param [Integer] id Ticket's id.
        #
        # @param [Hash] body Hash with ticket's attributes to update.
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @raise  [Workflow::Ticket] if a ticket with the given ID could not be found,
        #     if format of some attribute(s) is wrong (e.g. date and published_at
        #     should be passed as unix timestamps).
        # @return [Hash] Hash of ticket's attibutes.
        def update(id, body, options = {})
          member(:patch, id, nil, body, options)
        end

        # Sync ticket's analytics.
        #
        # @param [Hash] body Hash with ticket's attributes to update.
        #
        # @param [Hash] options Additional options (explicit HTTP headers,
        #     specific Client object).
        #
        # @return [Array] Array of hashes with ticket's views and comment counts
        #      and the result of syncing.
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
