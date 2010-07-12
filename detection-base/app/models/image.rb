require 'cvwrapper'
include CVWrapper

class Image < ActiveRecord::Base

  validates_uniqueness_of :resource

  #download the image after the resource was created in the database
  def after_save
    download_image
    scan_image
  end

  private
    
  def download_image
    #split url in different parts
    uri = URI.parse(self[:resource])

    #attempt to download the file
    Net::HTTP.start( uri.host ) { |http|
      #check if the header file size is smaller then the maximum upload limit
      response = http.request_head( uri.request_uri )
      file_size = response['content-length']
      #check file size
      if (file_size.to_i <= MAX_FILE_SIZE)
        response = http.get( uri.request_uri )
        open("public/images/cache/" + self.id.to_s, "w") { |file|
          file.write(response.body)
        } rescue raise "can not write to file"
      else
        raise "file size too big"
      end
    }
  end

  def scan_image
    file = 'public/images/cache/' + self[:id].to_s
    foo = Detector.find(file)
    foo[:regions].each do |region|
      r = Region.new
      r.image_id = self[:id]
      r.top_left_x = region[:top_left_x]
      r.top_left_y = region[:top_left_y]
      r.bottom_right_x = region[:bottom_right_x]
      r.bottom_right_y = region[:bottom_right_y]
      r.save
    end
  end
end
