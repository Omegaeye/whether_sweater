class MapQuestService

    def self.get_lon_and_lat(location)
      response = conn.get('/geocoding/v1/address') do |f|
        f.params['location'] = location
      end 
      return {"lat": 39.738453,"lng": -104.984853} if response.env.response_body.nil?
      parse(response)[:results][0][:locations][0][:latLng]
    end 


    def self.get_direction(from, to)
      response = conn.get('/directions/v2/route') do |f|
        f.params['from'] = from
        f.params['to'] = to
      end 
      parse(response)[:route]
      
      
    end 

    private

    def self.conn
        conn = Faraday.new('http://www.mapquestapi.com', params: { key: ENV['key'] })
    end

    def self.parse(response)
        JSON.parse(response.body, symbolize_names: true)
    end
    
end