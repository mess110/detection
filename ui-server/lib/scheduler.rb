class Scheduler

  def self.process_image img
    r = Runner.assign(img)
    eta = RestClient.get "http://#{r.host}:#{r.port}/detect", { :params => { :image_id => img.id, :url => img.url } }
    return eta
  end
end
