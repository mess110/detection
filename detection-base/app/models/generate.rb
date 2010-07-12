class Generate
  require "digest/sha1"

  def self.key(length = 10)
    Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..length]
  end

  def self.secret(length = 10)
    Digest::SHA1.hexdigest(Time.now.to_s + "i like pie")[1..length]
  end
end
