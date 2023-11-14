require './smart_id/version'
require './smart_id/utils/authentication_hash'
require './smart_id/utils/certificate_validator'
require './smart_id/utils/verification_code_calculator'
require './smart_id/api/request'
require './smart_id/api/response'
require './smart_id/api/confirmation_response'
require './smart_id/api/authentication/identity_number'
require './smart_id/api/authentication/document'
require './smart_id/api/authentication/confirmation_poller'
require './smart_id/authentication_certificate/certificate'
require './smart_id/authentication_certificate/content'
require './smart_id/api/signing/identity_number'
require './smart_id/api/signing/document'
require './smart_id/api/signing/confirmation_poller'

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

SmartId.configure do |config|
  config.relying_party_uuid = '00000000-0000-0000-0000-000000000000'
  config.relying_party_name = 'DEMO'
  config.default_certificate_level = 'QUALIFIED'
  config.poller_timeout_seconds = 10
  config.environment = 'DEMO'
end


# User enables Smart ID authentication or logs in with Smart ID
authentication_hash = SmartId::Utils::AuthenticationHash.new
auth_response = SmartId::Api::Authentication::IdentityNumber.authenticate(
  country: 'EE',
  identity_number: '50001029996',
  authentication_hash: authentication_hash,
  allowed_interactions_order: [
    {
      type: 'displayTextAndPIN',
      displayText60: 'Agrorodeo Smart ID autentifikacija'
    }
  ]
)

# Server awaits for user confirmation
authentication_hash_confirm = SmartId::Utils::AuthenticationHash.new(authentication_hash.hash_data)
confirmation_response = SmartId::Api::Authentication::ConfirmationPoller.confirm(
  session_id: auth_response.session_id,
  authentication_hash: authentication_hash_confirm,
  poll: true
)
p authentication_hash_confirm
p confirmation_response