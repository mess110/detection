require 'rubygems'
require 'detection'

#notice parameters are sent as hash object.

puts Detection.auth({:email => '[YOUR_EMAIL]', :pass => '[YOUR_PASSWORD]'})

puts Detection.detect( {:key => '[YOUR_KEY]', 
                        :secret => '[YOUR_SECRET]',
                        :url => '[YOUR_URL]'})
