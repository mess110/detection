#this is the proper way to include files. (i think)
require File.dirname(__FILE__) + '/data'
require "opencv"
include OpenCV

module CVWrapper
  class Detector
    class << self
      def find( file, data = HaarCascade::FRONTAL_FACE_TREE )
        
        start_time = Time.now
        
        detector = CvHaarClassifierCascade::load(data)
        image = IplImage.load(file)

        regions = Array.new

        detector.detect_objects(image) do |region|
          regions << {
            :top_left_x => region.top_left.x,
            :top_left_y => region.top_left.y,
            :bottom_right_x => region.bottom_right.x,
            :bottom_right_y => region.bottom_right.y
          }
        end

        total_time = Time.now - start_time

        result = {
          :regions  => regions,
          :duration => total_time
        }
      end
    end
  end
end
