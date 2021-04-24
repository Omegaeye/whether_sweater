require 'ostruct'

class WeatherFacade

    def self.get_forecast(city_and_state)
        data = OpenStruct.new({ 
            id: nil,
            current_weather: get_current_weather(city_and_state),
            daily_weather: get_daily_weather(city_and_state),
            hourly_weather: get_hourly_weather(city_and_state)
         })
    end
    

    def self.get_current_weather(city_and_state)
        forecast = get_weather(lon_and_lat(city_and_state).lon, lon_and_lat(city_and_state).lat)
        current_weather = { 
            datetime: Time.at(forecast[:current][:dt]).to_s(:db),
            sunrise: Time.at(forecast[:current][:sunrise]).to_s(:time),
            sunset: Time.at(forecast[:current][:sunset]).to_s(:time),
            temp: (((forecast[:current][:temp] - 273) * 1.8) + 32).round(2),
            feels_like: (((forecast[:current][:feels_like] - 273) * 1.8) + 32).round(2),
            humidity: forecast[:current][:humidity].to_f,
            uvi: forecast[:current][:uvi].to_f,
            visibility: forecast[:current][:visibility].to_f,
            conditions: forecast[:current][:weather].first[:description],
            icon: forecast[:current][:weather].first[:icon]
          }
    end

    def self.get_hourly_weather(city_and_state)
        forecast = get_weather(lon_and_lat(city_and_state).lon, lon_and_lat(city_and_state).lat)
        hourly = forecast[:hourly].map do |hour|
           { 
                time: Time.at(hour[:dt]).to_s(:time),
                temp: (((hour[:temp] - 273) * 1.8) + 32).round(2),
                conditions: hour[:weather].first[:description],
                icon: hour[:weather].first[:icon]
             }
        end
        hourly.first(8)
    end

   def self.get_daily_weather(city_and_state)
        forecast = get_weather(lon_and_lat(city_and_state).lon, lon_and_lat(city_and_state).lat)
        daily = forecast[:daily].map do |day|
           { 
                date: Time.at(day[:dt]).to_date,
                sunrise: Time.at(day[:sunrise]).to_s(:time),
                sunset: Time.at(day[:sunset]).to_s(:time),
                max_temp: (((day[:temp][:max] - 273) * 1.8) + 32).round(2),
                min_temp: (((day[:temp][:min] - 273) * 1.8) + 32).round(2),
                conditions: day[:weather].first[:description],
                icon: day[:weather].first[:icon]
             }
        end
        daily.first(5)
    end
    
    
    def self.lon_and_lat(city_and_state)
        location =  MapQuestService.get_lon_and_lat(city_and_state)

        lon_and_lat ||= OpenStruct.new({ 
            lon: location[:lng],
            lat: location[:lat]
         })

        lon_and_lat
    end

    def self.get_weather(lon, lat)
        weather ||= WeatherService.get_forecast(lon, lat)
    end
end