class Image < ActiveRecord::Base
  has_many :query
  has_many :regions
end
