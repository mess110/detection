require "digest/sha1"

class User < BaseResource
  self.element_name = "user"

  def valid_login?(passwd)
    self.pass == Digest::SHA1.hexdigest(passwd)[0..31]
  end
end
