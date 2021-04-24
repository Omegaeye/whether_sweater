require 'ostruct'

class WeatherFacade

    def self.get_forecast(location)
        data = OpenStruct.new({ 
            id: nil,
            current_weather: get_current_weather(location),
            daily_weather: get_daily_weather(location),
            hourly_weather: get_hourly_weather(location)
         })
    end
    

    def self.get_current_weather(location)
        forecast = get_weather(lon_and_lat(location).lon, lon_and_lat(location).lat)
        current_weather = { 
            datetime: Time.at(forecast[:current][:dt]).to_s(:db),
            sunrise: Time.at(forecast[:current][:sunrise]).to_s(:time),
            sunset: Time.at(forecast[:current][:sunset]).to_s(:time),
            temp: forecast[:current][:temp],
            feels_like: forecast[:current][:feels_like],
            humidity: forecast[:current][:humidity].to_f,
            uvi: forecast[:current][:uvi].to_f,
            visibility: forecast[:current][:visibility].to_f,
            conditions: forecast[:current][:weather].first[:description],
            icon: forecast[:current][:weather].first[:icon]
          }
    end

    def self.get_hourly_weather(location)
        forecast = get_weather(lon_and_lat(location).lon, lon_and_lat(location).lat)
        hourly = forecast[:hourly].map do |hour|
           { 
                time: Time.at(hour[:dt]).to_s(:time),
                temp: hour[:temp],
                conditions: hour[:weather].first[:description],
                icon: hour[:weather].first[:icon]
             }
        end
        hourly.first(8)
    end

   def self.get_daily_weather(location)
        forecast = get_weather(lon_and_lat(location).lon, lon_and_lat(location).lat)
        daily = forecast[:daily].map do |day|
           { 
                date: Time.at(day[:dt]).to_date,
                sunrise: Time.at(day[:sunrise]).to_s(:time),
                sunset: Time.at(day[:sunset]).to_s(:time),
                max_temp: day[:temp][:max],
                min_temp: day[:temp][:min],
                conditions: day[:weather].first[:description],
                icon: day[:weather].first[:icon]
             }
        end
        daily.first(5)
    end
    
    
    def self.lon_and_lat(location)
        location =  MapQuestService.get_lon_and_lat(location)

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