module SmartId
  class Exception < ::Exception; end
  class InvalidParamsError < Exception
    def message
      ""
    end
  end

  class SSLCertificateNotVerified < Exception
    def message
      ""
    end
  end

  class InvalidResponseCertificate < Exception
    def message
      ""
    end
  end

  class InvalidResponseSignature < Exception
    def message
      ""
    end
  end

  class UserNotFoundError < Exception
    def message
      "Dėmesio! Patikrink ar teisingai nurodytas asmens kodas."
    end
  end

  class OutdatedApiError < Exception
    def message
      ""
    end
  end

  class SystemUnderMaintenanceError < Exception
    def message
      ""
    end
  end

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
      "Naudojate nekvalifikuotą SmartID parašą, todėl patvirtinimas negalimas. Prašome atnaujinti SmartID parašą į kvalifikuotą."
    end
  end
end
