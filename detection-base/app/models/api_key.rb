class ApiKey < ActiveRecord::Base
  validates_uniqueness_of :key
  #validate format of key and secret
  #before searching check if it is activated or blocked
end
