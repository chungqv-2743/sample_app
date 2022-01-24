class Authentication
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  class << self
    def encode payload
      payload[:exp] = 24.hours.from_now.to_i
      JWT.encode(payload, HMAC_SECRET)
    end

    def decode token
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise ExceptionHandler::ExpiredSignature, e.message
    end
  end
end
