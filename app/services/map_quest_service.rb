class MapQuestService

    def self.get_lon_and_lat(location)
      response = conn.get('/geocoding/v1/address') do |f|
        f.params['location'] = location
      end 
      return [false,'Lets try something on this Earth'] if response.env.response_body.nil?
      parse(response)[:results][0][:locations][0][:latLng]
    end 


    def self.get_direction(from, to)
      response = conn.get('/directions/v2/route') do |f|
        f.params['from'] = from
        f.params['to'] = to
      end 
    
      return [false,'You will need a jetpack for that route'] if parse(response)[:info][:statuscode] == 402 || parse(response)[:info][:statuscode] == 500
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