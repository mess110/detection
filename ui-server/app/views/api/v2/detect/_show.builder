xml.image do
  xml.id @img.id
  xml.status @img.status
  xml.url @img.url
  xml.regions do
    @img.regions.each do |r|
      xml.region( :top_left_x     => r[:tlx],
                  :top_left_y     => r[:tly],
                  :bottom_right_x => r[:brx],
                  :bottom_right_y => r[:bry])
    end
  end
end
