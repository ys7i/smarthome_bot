# frozen_string_literal: true

class Device < ApplicationRecord
  scope :bulb, -> { where(device_type: 'Color Bulb') }
end
