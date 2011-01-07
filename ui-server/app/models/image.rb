class Image < ActiveRecord::Base
  has_many :regions
  belongs_to :runner
end
