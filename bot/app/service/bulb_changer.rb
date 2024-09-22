# frozen_string_literal: true

class BulbChanger
  def execute
    bulbs = Device.bulb
    today_afternoon_chance_of_rain = Weather::WeatherApi.new.chance_of_rain
    if today_afternoon_chance_of_rain.nil?
      raise NotImplementedError,
            'no weather data'
    end
    return if today_afternoon_chance_of_rain < 60

    colors = if today_afternoon_chance_of_rain >= 80
               [100, 100,
                250]
             else
               [230, 230, 255]
             end

    switch_bot = SwitchBot::SwitchBot.new
    bulbs.each do |bulb|
      switch_bot.set_color(bulb.device_id, colors)
      switch_bot.turn_off(bulb.device_id)
    end
  end
end
