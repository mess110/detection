require 'rubygems'

# if it is a opencv which is not installed as a gem
if ARGV[0] == "opencv"
  begin
    require ARGV[0]
    exit 0
  rescue LoadError => e
    exit 1
  end
# it means it is a gem so we need to chec if it is avaliable
elsif Gem.available?(ARGV[0])
  exit 0
else
  exit 1
end
