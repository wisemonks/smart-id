require './smart_id/api/signing/base'

module SmartId::Api
  module Signing
    class Document < Base
      BASE_URI = 'signature/document'

      def initialize(**opts)
        @document_number = opts[:document_number]
        super(**opts)
      end

      private

      def api_uri
        "#{BASE_URI}/#{@document_number}"
      end
    end
  end
end
