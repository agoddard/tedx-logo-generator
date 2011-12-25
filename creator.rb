require 'RMagick'
require 'sinatra'
include Magick


get '/:name/:type' do

  
  @type = params['type']


  def tedx(color, height, name_x, name_y, tag1_x, tag1_y, tag2_x, tag2_y)
    max_chars = 20;

    name = params['name'] # todo - trim the name to 20 chars
    # if the first 4 chars are TEDx, trim them off
    width = name.length*110 + (name_x == "420" ? 450 : 0)
    if (tag2_x == 395 && width < 860)
      width = 860
    elseif (width < 530)
      width = 530
    end
  
    #black or white background? FIX!
    if color == "w"
      fill = "white"
    else
      fill = "black"
    end
  
    # create a new image object
    image = Magick::ImageList.new
    image.new_image(width, height) {self.background_color = fill}
    #insert tedx png
    #insert independently png
    #insert organixed pnn
    image.format = "png"
    image.write("public/#{name}-#{@type}.png")
  end



  case @type
  	when '1'
  	  tedx("w", 240, 420, 136, 32, 162, 395, 162)
  	when '2'
  	  tedx("w", 290, 420, 136, 32, 162, 32, 214)
  	when '3'
  	  tedx("w", 370, 30, 267, 32, 293, 395, 293)
  	when '4'
  	  tedx("w", 420, 30, 267, 32, 293, 32, 345)
  	when '5'
  	  tedx("b", 240, 420, 136, 32, 162, 395, 162)
  	when '6'
  	  tedx("b", 290, 420, 136, 32, 162, 32, 214)
  	when '7'
  	  tedx("b", 370, 30, 267, 32, 293, 395, 293)
  	else
  	  tedx("b", 420, 30, 267, 32, 293, 32, 345)
    end
end