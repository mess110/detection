xml.query do
  xml.id response[:query_id]
  xml.time response[:time]
  xml.faces do
    response[:faces].each do |f|
      xml.face( :top_left_x     => f[:top_left_x],
                :top_left_y     => f[:top_left_y],
                :bottom_right_x => f[:bottom_right_x],
                :bottom_right_y => f[:bottom_right_y])
    end
  end
end

