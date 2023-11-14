require_relative 'smart_id/version'
require_relative 'smart_id/utils/authentication_hash'
require_relative 'smart_id/utils/certificate_validator'
require_relative 'smart_id/utils/verification_code_calculator'
require_relative 'smart_id/api/request'
require_relative 'smart_id/api/response'
require_relative 'smart_id/api/confirmation_response'
require_relative 'smart_id/api/authentication/identity_number'
require_relative 'smart_id/api/authentication/document'
require_relative 'smart_id/api/authentication/confirmation_poller'
require_relative 'smart_id/authentication_certificate/certificate'
require_relative 'smart_id/authentication_certificate/content'
require_relative 'smart_id/api/signing/identity_number'
require_relative 'smart_id/api/signing/document'
require_relative 'smart_id/api/signing/confirmation_poller'

module SmartId
  @@environment = 'DEMO' # possible options are demo and production
  @@relying_party_uuid = nil
  @@relying_party_name = nil
  @@default_certificate_level = 'ADVANCED' # possible values are "ADVANCED", "QUALIFIED"
  @@poller_timeout_seconds = 10
  @@allowed_interactions_order = [
    {
      type: 'displayTextAndPIN',
      displayText60: 'Authentication'
    }
  ]

  def self.configure
    yield(self)
  end

  def self.allowed_interactions_order=(value)
    @@allowed_interactions_order = value
  end

  def self.relying_party_uuid=(value)
    @@relying_party_uuid = value
  end

  def self.relying_party_uuid
    @@relying_party_uuid
  end

  def self.relying_party_name=(value)
    @@relying_party_name = value
  end

  def self.relying_party_name
    @@relying_party_name
  end

  def self.default_certificate_level=(value)
    @@default_certificate_level = value
  end

  def self.default_certificate_level
    @@default_certificate_level
  end

  def self.poller_timeout_seconds=(value)
    @@poller_timeout_seconds = value
  end

  def self.poller_timeout_seconds
    @@poller_timeout_seconds
  end

  def self.environment=(value)
    @@environment = value.upcase
  end

  def self.environment
    @@environment
  end
end