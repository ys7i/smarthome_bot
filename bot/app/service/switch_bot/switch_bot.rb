# frozen_string_literal: true

module SwitchBot
  class SwitchBot
    class SwitchBotAPIError < StandardError; end

    def initialize
      build_http_client
    end

    def fetch_all_devices
      execute_command(GetDevicesCommand)
    end

    private

    def build_http_client
      @connection = Faraday.new(url: 'https://api.switch-bot.com') do |conn|
        conn.adapter :typhoeus
      end
    end

    def execute_command(command_class)
      command = command_class.new(@connection)
      command.execute
    end
  end
end
