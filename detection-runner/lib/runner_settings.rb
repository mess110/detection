class RunnerSettings
  def self.image_store_path
    File.join(Rails.root, "public", "images")
  end
end
