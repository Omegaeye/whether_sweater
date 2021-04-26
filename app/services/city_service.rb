class CityService

    def self.get_city(search)
    response = conn.get('/api/cities/') do |f|
      f.params['search'] = search
      f.params['limit'] = 1
    end
        return "https://api.teleport.org/api/cities/geonameid:5419384/" if response.env.request_body.nil?
        parse(response)['_embedded']['city:search-results'][0]['_links']['city:item']['href']
    end 

    def self.get_city_info(search)
        response = Faraday.get(get_city(search))
        parse(response)
    end

    def self.get_urban_area(search)
        response = Faraday.get(get_city_info(search)['_links']['city:urban_area']['href'])
        parse(response)
    end


    def self.get_salaries(search)
        response = Faraday.get(get_urban_area(search)['_links']['ua:salaries']['href'])
        parse(response)['salaries']
    end
    

     private

    def self.conn
        conn = Faraday.new('https://api.teleport.org')
    end

    def self.parse(response)
        JSON.parse(response.body)
    end
    
end