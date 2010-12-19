require "light_opencv"
include LightOpencv

module LightOpencvWrapper

  DEFAULT_CASCADE_PATH = File.join(File.dirname(__FILE__), "haarcascade_frontalface_alt_tree.xml")

  class Detector
    class << self
      def find( file )
        raise "could not load image" if !File.exists?(file)
        raise "could not load cascade" if !File.exists?(DEFAULT_CASCADE_PATH)

        light_opencv_array = detect(file, DEFAULT_CASCADE_PATH)
        return format light_opencv_array
      end
    end

    private

    def self.format light_opencv_array
      regions = []
      0.step(light_opencv_array.size, 4) { |idx|
        regions << {
          :tlx => light_opencv_array[idx + 0],
          :tly => light_opencv_array[idx + 2],
          :brx => light_opencv_array[idx + 1],
          :bry => light_opencv_array[idx + 3]
        }
      }
      regions
    end
  end 
end

