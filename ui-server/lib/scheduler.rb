class Scheduler

  def self.process_queue image_id
    # get all the images that are not completed and not failed ordered by time
    i = Image.find(image_id)
    # find the available runners
    r = Runner.find(2)
    # assing the image to the runner and fire away
    i.runner_id = r.id
    i.save!
    eta = RestClient.get "http://#{r.host}:#{r.port}/detect", { :params => { :image_id => i.id, :url => i.url } }
    # return estimate running time
    return eta
  end
end
