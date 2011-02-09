require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "that only valid urls are saved" do
    img = Factory.new(:image)
    assert img.valid?
  end
end
