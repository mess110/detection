require 'encrypt'

class User < BaseResource
  self.element_name = "user"

  def valid_login?(passwd)
    self.pass == Encrypt.password(passwd)
  end
end
