# frozen_string_literal: true

module SwitchBot
  class TurnCommand < AbstractCommand
    def execute(device_id, is_on)
      header = build_header
      body = {
        command: is_on ? "turnOn" : "turnOff",
        commandType: "command"
      }.to_json
      response = @connection.post("v1.1/devices/#{device_id}/commands", body,
                                  header)
      return response if response.success?

      raise SwitchBotAPIError "POST v1.1/devices/#{device_id}/commands failed"
    end
  end
end
