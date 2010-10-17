# startup script that needs A LOT MORE WORK
# this is just a very blah ugly version to make it work NOW

DETECTION_BASE  = "detection-base/script/server -d"
DETECTION_API   = "detection-api/script/server -d -p 1234"

# check weather a service is online. it would be nice if I
# would fix this one day. It is working but I don't think
# it is very cross platform.
def online? service
  pid = 0
  tmp_pid = 0
  count = 0
  `pgrep -f "#{service}"`.each do |p|
    if count == 0
      tmp_pid = p.to_i
    end
    count += 1
  end
  if count > 1
    pid = tmp_pid
  end
  pid.to_i
end

def status
  detection_base = online? DETECTION_BASE
  detection_api  = online? DETECTION_API
  puts
  puts "Checking status of services.."
  puts
  puts "detection-base running:    #{detection_base != 0}"
  puts "detection-api  running:    #{detection_api != 0}"
  puts
end

def start
  system("./#{DETECTION_BASE}")
  system("./#{DETECTION_API}")
  # enough time to fail
  sleep 5
  status
end

def stop
  detection_base  = online? DETECTION_BASE
  detection_api   = online? DETECTION_API
  Process.kill(9, detection_base) if detection_base != 0
  Process.kill(9, detection_api) if detection_api != 0
  sleep 1
  status
end

def help
  puts
  puts "Script to check/stop/start running detection services"
  puts
  puts "Usage:"
  puts
  puts "  ruby services.rb -h"
  puts "  ruby services.rb status"
  puts "  ruby services.rb start"
  puts "  ruby services.rb stop"
  puts
end

if !ARGV[0] || ARGV[0] == "-h"
  help
  exit 0
elsif ARGV[0] == "status"
  status
elsif ARGV[0] == "start"
  start
elsif ARGV[0] == "stop"
  stop
end

