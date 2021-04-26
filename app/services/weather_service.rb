class WeatherService

  def self.get_forecast(lon, lat)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params['lon'] = lon
      f.params['lat'] = lat
      f.params['units'] = 'imperial' 
      f.params['exclude'] = 'minutely'
    end 
    parse(response)
  end 

  def self.get_eta_weather(lon, lat, time)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params['lon'] = lon
      f.params['lat'] = lat
      f.params['units'] = 'imperial' 
      f.params['exclude'] = 'minutely'
      f.params['dt'] = time
    end 
    
    parse(response)[:current]
  end 

    private

  def self.conn
     conn = Faraday.new('http://api.openweathermap.org', params: { appid: ENV['appid'] })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
    

end