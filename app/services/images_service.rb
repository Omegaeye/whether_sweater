class ImagesService
  def self.get_image_id(location)
    response = conn.get('/services/rest') do |f|
      f.params['method'] = 'flickr.photos.search'
      f.params['text'] = location
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end
    return ['Lets try something on this Earth'] if parse(response)[:stat] == 'fail'

    parse(response)[:photos][:photo][0][:id]
  end

  def self.get_image(location)
    image_id = get_image_id(location)
    return image_id if image_id.class == Array
    response = conn.get('/services/rest') do |f|
      f.params['method'] = 'flickr.photos.getInfo'
      f.params['photo_id'] = image_id
      f.params['page'] = 1
      f.params['per_page'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
    end
    parse(response)[:photo]
  end

  def self.conn
    conn = Faraday.new('https://www.flickr.com', params: { api_key: ENV['api_key'] })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
