class RoadTripFacade
  def self.road_trip(from, to)
    dir = direction(from, to)
    return dir if dir.class == Array 
    trip = OpenStruct.new({
                            id: nil,
                            start_city: from,
                            end_city: to,
                            travel_time: dir[:travel_time],
                            weather_at_eta: eta_weather(dir[:lon], dir[:lat], dir[:dt])
                          })
  end

  def self.direction(from, to)
    direction = MapQuestService.get_direction(from, to)
    
    return direction if direction.class == Array
    
    direction_hash ||= {
      travel_time: ActiveSupport::Duration.build(direction[:time]).inspect,
      dt: direction[:time],
      lon: direction[:locations][1][:latLng][:lng],
      lat: direction[:locations][1][:latLng][:lat]
    }
    direction_hash
  end

  def self.eta_weather(lon, lat, time)
    if time > 172_800
      daily_weather_info(lon, lat, time)
    else
      hourly_weather_info(lon, lat, time)
    end
  end

  def self.get_eta_weather_info(lon, lat)
    weather_info ||= WeatherService.get_forecast(lon, lat)
    weather_info
  end

  def self.daily_weather_info(lon, lat, time)
    temp = []
    summary = []
    get_eta_weather_info(lon, lat)[:daily].find_all do |day|
      if time + Time.now.to_i >= day[:dt]
        temp << "#{day[:temp][:day]} F"
        summary << day[:weather][0][:description]
      end
    end
    {
      temperature: temp.last,
      summary: summary.last
    }
  end

  def self.hourly_weather_info(lon, lat, time)
    temp = []
    summary = []
    get_eta_weather_info(lon, lat)[:hourly].find_all do |hour|
      if time + Time.now.to_i >= hour[:dt]
        temp << "#{hour[:temp]} F"
        summary << hour[:weather][0][:description]
      end
    end
    {
      temperature: temp.last,
      summary: summary.last
    }
  end

end
