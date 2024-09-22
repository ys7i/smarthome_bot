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

    def set_color(device_id, rgb)
      execute_command(SetColorCommand, device_id, rgb)
    end

    def turn_off(device_id)
      execute_command(TurnCommand, device_id, false)
    end

    private

    def build_http_client
      @connection = Faraday.new(url: 'https://api.switch-bot.com') do |conn|
        conn.adapter :typhoeus
      end
    end

    def execute_command(command_class, *args)
      command = command_class.new(@connection)
      command.execute(*args)
    end
  end
end
