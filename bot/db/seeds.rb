# frozen_string_literal: true

class InitDevice
  def self.run
    service = SwitchBot::SwitchBot.new
    devices = service.fetch_all_devices
    devices.each(&:save)
  end
end

InitDevice.run
