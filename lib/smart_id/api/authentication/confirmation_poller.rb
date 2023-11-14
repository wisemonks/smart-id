module SmartId::Api
  module Authentication
    class ConfirmationPoller
      BASE_URI = 'session/'

      def self.confirm(session_id:, authentication_hash:, poll: true)
        new(session_id, authentication_hash, poll).call
      end

      def initialize(session_id, authentication_hash, poll)
        @session_id = session_id
        @authentication_hash = authentication_hash
        @poll = poll
      end

      def call
        params = { timeoutMs: SmartId.poller_timeout_seconds * 1000 }
        uri = BASE_URI + @session_id

        raw_response = SmartId::Api::Request.execute(method: :get, uri: uri, params: params)
        response = SmartId::Api::ConfirmationResponse.new(
          JSON.parse(raw_response.body),
          @authentication_hash.hash_data
        )

        # repeat request if confirmation is still running
        if response.confirmation_running? && @poll
          call
        else
          response
        end
      end
    end
  end
end
