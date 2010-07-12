class Error < ActiveRecord::Base
  def self.log(level, title, params, backtrace, api_key)
    Error.new(:level => level.to_s, :title => title,
        :backtrace => backtrace, :handled => false,
        :api_key_id  => api_key, :params => params).save
  end
end
