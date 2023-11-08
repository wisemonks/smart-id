require "smart_id/api/authentication/base"
require "smart_id/exceptions"

module SmartId::Api
  module Authentication
    class IdentityNumber < Base
      BASE_URI = "authentication/etsi"

      # @param country: 2 character ISO 3166-1 alpha-2 format(for example EE, LT, LV, KZ)
      # @param identity_number: national identity number of the individuals
      def initialize(**opts)
        @country = opts[:country].upcase
        @identity_number = opts[:identity_number]
        @allowed_interactions_order = opts[:allowed_interactions_order]

        unless @country && @identity_number && @allowed_interactions_order
          raise InvalidParamsError
        end

        super(**opts)
      end

      private

      def api_uri
        "#{BASE_URI}/PNO#{@country}-#{@identity_number}"
      end
    end
  end
end
