# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :device_name
      t.string :device_type
      t.string :hub_device_id
      t.boolean :enable_cloud_service
      t.timestamps
    end
  end
end
