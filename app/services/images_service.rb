class ImagesService

  def self.get_image_id(location)
    response = conn.get('/services/rest') do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params['text'] = location
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end 

    return '51123309253' if parse(response)[:photos][:photo].empty? 
    parse(response)[:photos][:photo][0][:id] 
  end 

  def self.get_image(location)
    image_id = get_image_id(location)
    response = conn.get('/services/rest') do |f|
      f.params['method'] = 'flickr.photos.getInfo'
      f.params['photo_id'] = image_id
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end 
    parse(response)[:photo]
  end
  

    private

  def self.conn
     conn = Faraday.new('https://www.flickr.com', params: { api_key: ENV['api_key'] })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
    

end