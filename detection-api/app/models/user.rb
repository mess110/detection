require 'encrypt'

class User < BaseResource
  self.element_name = "user"

  def password?(passwd)
    self.pass == Encrypt.password(passwd)
  end
end
