class User < ActiveRecord::Base
  validates_uniqueness_of :email, :message => "email already exists"
  validates_format_of :email, :with => /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$/,
    :message => "invalid email format"
  validates_format_of :pass, :with => /^[a-zA-Z0-9]{4,32}$/,
    :message => "invalid password. Between 4 and 32 characters, lower upper case letters and numbers"

  #validate secret as well

  def after_create
    key = Generate.key
    secret = Generate.secret
    id = self.id
    ApiKey.create([{ :key => key, :secret => secret, :user_id => id}])
  end
end
