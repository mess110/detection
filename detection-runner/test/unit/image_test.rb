require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "valid_url" do
    img = File.read(File.join(Rails.root.to_s, "test", "fixtures", "test.jpg"))
  
    FakeWeb.register_uri(:get, "http://cheezburger.com/icanhaz.jpg",
                         :body => img)
    FakeWeb.register_uri(:get, "http://cheezburger.com/icanhaz.jpg",
                         :body => img)
    FakeWeb.register_uri(:get, "http://cheezburger.com/icanhaz.jpg",
                         :body => img)

    assert_raise (ActiveRecord::RecordInvalid) do
      Image.create!(:url => "")
    end
    assert_raise (ActiveRecord::RecordInvalid) do
      Image.create!(:url => "boom://cheezburger.com")
    end
    assert_raise (ActiveRecord::RecordInvalid) do
      Image.create!(:url => "boom://cheezburger.com/icanhaz.jpg")
    end
    assert_raise (ActiveRecord::RecordInvalid) do
      Image.create!(:url => "http://cheezburger.com/icanhaz.img")
    end
    assert_nothing_raised do
      Image.create!(:url => "http://cheezburger.com/icanhaz.jpg")
      Image.create!(:url => "https://cheezburger.com/icanhaz.jpg")
      Image.create!(:url => "http://cheezburger.com/icanhaz.jpeg")
      Image.create!(:url => "https://cheezburger.com/icanhaz.jpeg")
    end
  end
end
