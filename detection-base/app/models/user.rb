class User < ActiveRecord::Base
  validates_uniqueness_of :email, :message => "email already exists"
  validates_format_of :email, :with => /^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$/,
    :message => "invalid format"
  validates_format_of :pass, :with => /^[a-zA-Z0-9]{4,32}$/,
    :message => "invalid. Between 4 and 32 characters, lower upper case letters and numbers"

  def before_save
    cur = self[:pass]
    self[:pass] = self.class.hash_password(cur)
  end

  def after_save
    key = Generate.key
    secret = Generate.secret
    id = self.id
    ApiKey.create([{ :key => key, :secret => secret, :user_id => id}])
  end

  private

  #TODO make a gem for password encryption. that way it will work on clientside
  #as well.
  def self.hash_password(password)
    Generate.pass_encrypt(password)
  end
end
