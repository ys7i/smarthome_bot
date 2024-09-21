# frozen_string_literal: true

module SwitchBot
  class GetDevicesCommand < AbstractCommand
    def execute
      header = build_header
      response = @connection.get('v1.1/devices', nil, header)
      raise SwitchBotAPIError "GET v1.1/devices failed" unless response.success?

      data = JSON.parse(response.body, symbolize_names: true)
      device_list = data[:body][:deviceList]

      device_list.map do |device|
        Device.new(device_id: device[:deviceId],
                   device_name: device[:deviceName],
                   device_type: device[:deviceType],
                   hub_device_id: device[:hubDeviceId],
                   enable_cloud_service: device[:enableCloudService])
      end
    end
  end
end
