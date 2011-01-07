class Scheduler

  def self.process_queue
    # get all the images that are not completed and not failed ordered by time
    i = Image.find(3)
    # find the available runners
    r = Runner.find(2)
    # assing the image to the runner and fire away
    i.runner_id = r.id
    i.save!
    RestClient.get "http://#{r.host}:#{r.port}/detect", { :params => { :image_id => i.id, :url => i.url } }
    # return estimate running time
    return 42
  end
end
