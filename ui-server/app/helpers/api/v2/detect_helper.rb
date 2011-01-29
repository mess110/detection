module Api::V2::DetectHelper
  def format_error_description description
    case description
      when Image::INVALID_PROTOCOL
        "The only allowed protocols are http and https"
      when Image::INVALID_IMAGE_FORMAT
        "Only URLs to jpg/jpeg images"
      else
        description
      end
  end
end
