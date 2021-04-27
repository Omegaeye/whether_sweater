class WeatherService

  def self.get_forecast(lon, lat)
    response = conn.get('/data/2.5/onecall') do |f|
      f.params['lat'] = lat
      f.params['lon'] = lon
      f.params['units'] = 'imperial' 
      f.params['exclude'] = 'minutely'
    end 
    parse(response)
  end 

    private

  def self.conn
     conn = Faraday.new('http://api.openweathermap.org', params: { appid: ENV['appid'] })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
    

end