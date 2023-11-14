require 'securerandom'
require 'base64'
require 'openssl'

module SmartId
  module Utils
    class AuthenticationHash
      attr_reader :hash_data

      def initialize(hash_data = nil)
        @hash_data = hash_data || random_bytes
      end

      def calculate_digest
        Digest::SHA256.digest(hash_data)
      end

      def calculate_base64_digest
        Base64.strict_encode64(calculate_digest)
      end

      private

      def random_bytes
        SecureRandom.random_bytes(64)
      end
    end
  end
end
