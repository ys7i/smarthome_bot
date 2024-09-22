# frozen_string_literal: true

module SwitchBot
  class SetColorCommand < AbstractCommand
    def execute(device_id, colors)
      header = build_header
      body = {
        command: "setColor",
        parameter: "#{colors[0]}:#{colors[1]}:#{colors[2]}",
        commandType: "command"
      }.to_json
      response = @connection.post("v1.1/devices/#{device_id}/commands", body,
                                  header)
      return response if response.success?

      raise SwitchBot::SwitchBot::SwitchBotAPIError,
            "POST v1.0/devices/bot/deviceId/commands failed"
    end
  end
end
