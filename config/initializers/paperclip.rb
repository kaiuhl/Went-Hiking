module Paperclip
  class Attachment
    def width(style = default_style)
      Paperclip::Geometry.from_file(to_file(style)).width
    end
 
    def height(style = default_style)
      Paperclip::Geometry.from_file(to_file(style)).height
    end
    
    def image?(style = default_style)
      to_file(style).image?
    end
  end
  
  module Upfile
    def image?
      ["image/jpeg", "image/tiff", "image/png", "image/gif", "image/bmp"].include?(content_type)
    end
  end
end