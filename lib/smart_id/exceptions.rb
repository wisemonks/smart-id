module SmartId
  class Exception < ::Exception; end
  class InvalidParamsError < Exception; end
  class SSLCertificateNotVerified < Exception; end
  class InvalidResponseCertificate < Exception; end
  class InvalidResponseSignature < Exception; end
  class UserNotFoundError < Exception
    def message
      "Vartotojas nerastas."
    end
  end
  class OutdatedApiError < Exception; end
  class SystemUnderMaintenanceError < Exception; end
  class UserRefused < Exception
    def message
      "Nesulaukėme jūsų teigiamo atsakymo."
    end
  end
  class Timeout < Exception
    def message
      "Nesulaukėme jūsų atsakymo."
    end
  end
  class InvalidPermissionsError < Exception
    def message
      "Relying Party teisių klaida."
    end
  end

  class ConnectionError < Exception;
    attr_reader :original_error
    def initialize(original_error)
      @original_error = original_error
    end 
  end

  class IncorrectAccountLevelError < Exception
    def message
      "Vartotojas turi turėti aukštesnį apsaugos lygį negu BASIC."
    end
  end
end
