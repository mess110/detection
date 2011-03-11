require 'httparty'

module RDetectionAPI
  class Detect
    include HTTParty
    base_uri 'http://detection.myvhost.de'

    def self.new url
      get("/api/v2/detect/new?url=#{url}")
    end
  end
end
