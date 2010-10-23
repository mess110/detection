require 'encrypt'

class User < ActiveRecord::Base
  validates_uniqueness_of :email, :message => "email already exists"
  validates_format_of :email, :with => /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$/,
    :message => "invalid format"
    #TODO fix this crap
  validates_format_of :pass, :with => /^[a-zA-Z0-9!@$#%^&*,.:;'"\|\-_ ]{4,32}$/,
    :message => "invalid. Between 4 and 32 characters, lower upper case letters and numbers"
    
  has_one :api_key

  def before_save
    self[:pass] = Encrypt.password(self[:pass])
  end

  def after_save
    api = ApiKey.new
    api.key = Encrypt.key
    api.secret = Encrypt.secret
    self.api_key = api
  end
end
