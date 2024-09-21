# frozen_string_literal: true

module SwitchBot
  class AbstractCommand
    def initialize(connection)
      @connection = connection
    end

    def build_header
      token = Rails.application.credentials.switchbot[:token]
      secret = Rails.application.credentials.switchbot[:secret]
      nonce = SecureRandom.uuid
      time_stamp = (Time.now.to_f * 1000).floor.to_s
      signature = Base64.strict_encode64(
        OpenSSL::HMAC.digest('sha256', secret, "#{token}#{time_stamp}#{nonce}")
      )

      {
        'Authorization' => token,
        'Content-Type' => 'application/json',
        'charset' => 'utf8',
        't' => time_stamp,
        'sign' => signature,
        'nonce' => nonce
      }
    end

    def execute
      raise NotImplementedError
    end
  end
end
