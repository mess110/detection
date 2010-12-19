class RunnerSettings
  def self.image_store_path
    File.join(Rails.root.to_s, "public", "images")
  end
end
