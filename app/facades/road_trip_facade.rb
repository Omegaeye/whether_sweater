class RoadTripFacade

    def self.road_trip(from, to)
        
        trip = OpenStruct.new({
            id: nil,
            start_city: from,
            end_city: to,
            travel_time: direction(from, to)[:travel_time],
            weather_at_eta: eta_weather(from, to)
        })
    end
    

    def self.direction(from, to)
        direction = MapQuestService.get_direction(from, to)
        direction_hash ||= { 
            travel_time: ActiveSupport::Duration.build(direction[:time]).inspect,
            dt: Time.parse(direction[:formattedTime]).to_i,
            lon: direction[:locations][1][:latLng][:lng],
            lat: direction[:locations][1][:latLng][:lat]
         }
         direction_hash
    end
    
    def self.eta_weather(from, to)
        location_info ||= direction(from, to)
                
        weather_info = WeatherService.get_eta_weather(location_info[:lon], location_info[:lat], location_info[:dt])
        { 
            temperature: weather_info[:temp],
            conditions: weather_info[:weather][0][:description]
         }
    end
    
end