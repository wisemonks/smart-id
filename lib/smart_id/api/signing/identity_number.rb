require_relative 'base'
require_relative '../../exceptions'

module SmartId::Api
  module Signing
    class IdentityNumber < Base
      BASE_URI = 'signature/pno'

      # @param country: 2 character ISO 3166-1 alpha-2 format(for example EE, LT, LV, KZ)
      # @param identity_number: national identity number of the individuals
      def initialize(**opts)
        @country = opts[:country].upcase
        @identity_number = opts[:identity_number]

        raise InvalidParamsError unless @country && @identity_number

        super(**opts)
      end

      private

      def api_uri
        "#{BASE_URI}/#{@country}/#{@identity_number}"
      end
    end
  end
end
