require 'cvwrapper'
include CVWrapper

class Image < ActiveRecord::Base

  has_many :regions

  validates_uniqueness_of :resource
  validates_format_of :resource, :with => URI::regexp(%w(http https)), :message => "invalid url!"
  validates_format_of :resource, :with => /.*\.(png|jpg|jpeg)$/i, :message => "invalid image format!"

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
    detector_results = Detector.find(image_path)
    detector_results[:regions].each do |region|
      self.regions << Region.new({
                        :top_left_x     => region[:top_left_x],
                        :top_left_y     => region[:top_left_y],
                        :bottom_right_x => region[:bottom_right_x],
                        :bottom_right_y => region[:bottom_right_y]
                      })
    end
  end
end
