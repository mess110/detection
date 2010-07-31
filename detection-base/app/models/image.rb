require 'cvwrapper'
include CVWrapper

class Image < ActiveRecord::Base

  validates_uniqueness_of :resource
  validates_format_of :resource, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/)+(.*\.(png|jpg|jpeg)$)/ix,
    :message => "invalid url!"

  #download the image after the resource was created in the database
  def after_save
    image_path = File.dirname(__FILE__) + '/../../public/images/cache/' + self[:id].to_s
    #TODO: this is a workaround. it seems normal but I think there is a better
    #way
    if self.not_found == false
      download_image image_path rescue
        begin
          self[:not_found] = true
          self.save
        end
    end
  end

  private
    
  def download_image(image_path)
    #split url in different parts
    uri = URI.parse(self[:resource])

    #attempt to download the file
    Net::HTTP.start( uri.host ) { |http|
      #check if the header file size is smaller then the maximum upload limit
      response = http.request_head( uri.request_uri )
      #file_size = response['content-length']
      #check file size
      #if (file_size.to_i <= MAX_FILE_SIZE.to_i)
        response = http.get( uri.request_uri )
        open(image_path, "w") { |file|
          file.write(response.body)
        } rescue raise "can not write to file"
        scan_image image_path
      #else
        #file too big code
      #end
    }
  end

  def scan_image(image_path)
    #file = 'public/images/cache/' + self[:id].to_s
    foo = Detector.find(image_path)
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
