require 'light_cv'

describe Spoc::LightCV do
  it "should be installed" do
    lambda { require 'light_opencv' }.should_not raise_error
  end

  it "should return 3 faces" do
    file_path = File.join(File.dirname(__FILE__), "test.jpg")
    faces = Spoc::LightCV.find(file_path)
    faces.should be_an_instance_of Array
    faces.count.should be 3
  end
end
