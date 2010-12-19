require "light_opencv_wrapper"

class Image < ActiveRecord::Base
  has_many :query
  has_many :regions

  validates_uniqueness_of :url
  validates_format_of :url,
                :with => URI::regexp(%w(http https)), :message => "invalid url"
  validates_format_of :url,
                :with => /.*\.(jpg|jpeg)$/i, :message => "invalid image format"

  def after_create
    download_image(url)
  end

  private

  def download_image(url)
    ActiveRecord::Base.transaction do
      uri = URI.parse(url)
      image_path = RunnerSettings.image_store_path + "/#{id}"
      Net::HTTP.start( uri.host ) { |http|
        response = http.get( uri.request_uri )
        open(image_path, "wb") { |file|
          file.write(response.body)
        }
      }
      scan_image id, image_path
    end
  end

  def scan_image image_id, image_path
    regions = LightOpencvWrapper::Detector.find(image_path)
    regions.each do |r|
      Region.create!(:image_id => id, :tlx => r[:tlx], :tly => r[:tly], :brx => r[:brx], :bry => r[:bry])
    end
  end
end
