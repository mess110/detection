class Scheduler

  RUNNERS_FULL = -1

  def self.process_image img    
    r = Runner.free.min {|a,b| a.images_count <=> b.images_count }
    return RUNNERS_FULL if r.nil?
    
    img.runner_id = r.id
    img.save!

    eta = RestClient.get "http://#{r.host}:#{r.port}/detect", { :params => { :image_id => img.id, :url => img.url } }
    return eta
  end
end
