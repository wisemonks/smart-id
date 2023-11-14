require './smart_id/api/authentication/base'
require './smart_id/exceptions'

module SmartId::Api
  module Authentication
    class IdentityNumber < Base
      BASE_URI = 'authentication/etsi'

      # @param country: 2 character ISO 3166-1 alpha-2 format(for example EE, LT, LV, KZ)
      # @param identity_number: national identity number of the individuals
      # @param allowed_interactions_order: customized order of allowed smart-id user interactions
      def initialize(**opts)
        @country = opts[:country].upcase
        @identity_number = opts[:identity_number]
        @allowed_interactions_order = opts[:allowed_interactions_order]

        raise InvalidParamsError unless @country && @identity_number && @allowed_interactions_order

        super(**opts)
      end

      private

      def api_uri
        "#{BASE_URI}/PNO#{@country}-#{@identity_number}"
      end
    end
  end
end
