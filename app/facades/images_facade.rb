require 'ostruct'

class ImagesFacade

    def self.get_image(location)
        image_data = ImagesService.get_image(location)
        return image_data if image_data.class == Array
        data = OpenStruct.new({ 
            id: nil,
            image: { 
            location: location,
            image_url: image_data[:urls][:url].first[:_content],
            credit: image_credit(image_data[:owner][:username])
         }})
    end

    def self.image_credit(author)
        { 
            source: 'flickr.com',
            author: author
         }
    end
end