killall -9 ruby
./detection-base/script/server -e production&
./detection-api/script/server -p 80 -e production&
