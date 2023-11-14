require 'json'
require 'rest-client'
require './smart_id/exceptions'
require './smart_id/utils/authentication_hash'

module SmartId::Api
  module Authentication
    class Base
      attr_reader :authentication_hash

      def self.authenticate(**opts)
        new(**opts).call
      end

      def initialize(**opts)
        @authentication_hash = opts[:authentication_hash]
        @display_text = opts[:display_text]
        @certificate_level = opts[:certificate_level]
        @multiple_choice = opts[:multiple_choice]
      end

      def call
        response = SmartId::Api::Request.execute(method: :post, uri: api_uri, params: request_params)
        SmartId::Api::Response.new(JSON.parse(response.body), authentication_hash)
      end

      private

      def request_params
        params = {
          relyingPartyUUID: SmartId.relying_party_uuid,
          relyingPartyName: SmartId.relying_party_name,
          certificateLevel: @certificate_level || SmartId.default_certificate_level,
          hash: authentication_hash.calculate_base64_digest,
          hashType: 'SHA256',
          allowedInteractionsOrder: @allowed_interactions_order || SmartId.default_allowed_interactions_order
        }

        params.merge!(displayText: @display_text) if @display_text

        params.merge!(requestProperties: { vcChoice: @multiple_choice }) if @multiple_choice

        params
      end

      def api_uri
        raise NotImplementedError
      end
    end
  end
end
