class Image < BaseResource
  self.element_name = "image"

  def self.find_or_create resource
    image = Image.find(:first, :params => { :resource => resource})
    if image.nil?
      image = Image.create(:resource => resource)
    end
    image
  end
end
