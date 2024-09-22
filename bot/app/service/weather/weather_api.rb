# frozen_string_literal: true

module Weather
  class WeatherApi
    class WeatherApiError < StandardError; end

    def initialize
      build_http_client
      @city_code = Rails.application.credentials.weather[:city_code]
    end

    def chance_of_rain
      weather_data = fetch_todays_afternoon_chance_of_rain
      value = find_afternoon_value_from_response(weather_data)
      if value.nil?
        raise NotImplementedError,
              "The afternoon data is not available"
      end

      value
    end

    private

    def fetch_todays_afternoon_chance_of_rain
      response = @connection.get("/api/forecast/city/#{@city_code}")

      unless response.success?
        raise WeatherApiError,
              'Failed to fetch weather data'
      end

      JSON.parse(response.body)
    end

    def find_afternoon_value_from_response(weather_data)
      today_data = weather_data['forecasts'].find { |d| d['dateLabel'] == "今日" }
      raise NotImplementedError, "not implemented" if today_data.nil?

      value = today_data['chanceOfRain']['T12_18'].match(/\d+/)
      return nil if value.nil?

      value[0].to_i
    end

    def build_http_client
      @connection = Faraday.new(url: 'https://weather.tsukumijima.net') do |conn|
        conn.adapter :typhoeus
      end
    end
  end
end
