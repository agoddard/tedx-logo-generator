require 'RMagick'
require 'sinatra'
include Magick


get '/:name' do
  name = params['name'] ||= "Name"
  erb :index, :locals => { :name => name }
end


get '/:name/:type' do
  content_type 'image/png'
  @type = params['type']

  def tedx(color, height, name_x, name_y, independently_x, independently_y, organized_x, organized_y)
    max_chars = 20;

    name = params['name'] # todo - trim the name to 20 chars, if the first 4 chars are TEDx, trim them off
    width = name.length*84
    if name_x == 420
      width = width + 420
    end
    if (organized_x == 395 && width < 860)
      width = 860
    elsif (width < 530)
      width = 530
    end
  
    if color == "w"
      fill = "white"
    else
      fill = "black"
    end
    
  
    image = Magick::ImageList.new
    image.new_image(width, height) {self.background_color = fill}  
    image = image.composite(ImageList.new("tedx#{color}.png"), Magick::NorthWestGravity, 30, 30, Magick::AtopCompositeOp)
    image = image.composite(ImageList.new("independently#{color}.png"), Magick::SouthWestGravity, independently_x, independently_y, Magick::AtopCompositeOp)
    image = image.composite(ImageList.new("organized#{color}.png"), Magick::NorthWestGravity, organized_x, organized_y, Magick::AtopCompositeOp)
    
    
  
    text = Magick::Draw.new
    text.font_family = 'helvetica'
    text.pointsize = 144
    text.kerning = 0
    text.text_antialias = true
    text.gravity = Magick::WestGravity
    text.annotate(image, 110,1,name_x - 20,name_y - 37, name) {
      self.fill = (color == "w" ? "black" : "white")
    }

    image.format = "png"
    return image.to_blob
  end

# color, height, name_x, name_y, independently_x, independently_y, organized_x, organized_y
# corrections in place of originals
  case @type
  	when '1'
  	  tedx("w", 240, 420, 136, 32, 162-130, 395, 165)
  	when '2'
  	  tedx("w", 290, 420, 136, 32, 162-80, 32, 214)
  	when '3'
  	  tedx("w", 370, 30+18, 267, 32, 293-259, 395, 293)
  	when '4'
  	  tedx("w", 420, 30+18, 267, 32, 293-213, 32, 345)
  	when '5'
  	  tedx("b", 240, 420, 136, 32, 162-130, 395, 165)
  	when '6'
  	  tedx("b", 290, 420, 136, 32, 162-80, 32, 214)
  	when '7'
  	  tedx("b", 370 + 10, 30+18, 267, 32, 293-249, 395, 293)
  	else
  	  tedx("b", 420, 30+18, 267, 32, 293-213, 32, 345)
    end
end