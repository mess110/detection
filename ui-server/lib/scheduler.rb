class Scheduler

  RUNNERS_FULL = -1

  def self.process_image img
    return RUNNERS_FULL if 1 == 2

    r = Runner.assign(img)
    eta = RestClient.get "http://#{r.host}:#{r.port}/detect", { :params => { :image_id => img.id, :url => img.url } }
    return eta
  end
end
