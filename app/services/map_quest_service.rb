class MapQuestService

    def self.get_lon_and_lat(location)
    response = conn.get('/geocoding/v1/address') do |f|
      f.params['location'] = location
    end 
    parse(response)[:results][0][:locations][0][:latLng]
  end 

    private

    def self.conn
        conn = Faraday.new('http://www.mapquestapi.com', params: { key: ENV['key'] })
    end

    def self.parse(response)
        JSON.parse(response.body, symbolize_names: true)
    end
    
end