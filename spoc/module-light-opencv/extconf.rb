# Loads mkmf which is used to make makefiles for Ruby extensions
require 'mkmf'

# Give it a name
extension_name = 'light_opencv'

dir_config(extension_name)

if CONFIG["arch"].include?("darwin")
	dir_config("ffcall", "/opt/local/include", "/opt/local/lib")
else
	dir_config("ffcall", "/usr/local/include", "/usr/local/lib")
end

opencv_libraries = ["cxcore", "cv", "highgui"]

puts ">> check require libraries..."
case CONFIG["arch"]
when /mswin32/
  have_library("msvcrt", nil)
  opencv_libraries.each{|lib|
    have_library(lib)
  }
else
  opencv_libraries.each{|lib|
    raise "lib#{lib} not found." unless have_library(lib)
  }
  have_library("stdc++")
end

# TODO!!! checking for headers

create_makefile(extension_name)

# since I don't know how to use mkmf properly, I write the required stuff
# manually
# This adds -L and -I flags
def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")
  f.each_line do |line|
    if line =~ /^ldflags\ \ \=\ \-\L\./
      data += line.gsub("\n","") + " #{`pkg-config --libs opencv`}\n"
    elsif line =~ /^INCFLAGS\ \=\ \-\I\./
      data += line.gsub("\n","") + " #{`pkg-config --cflags opencv`}\n"
    else
      data += line
    end
  end
  return data
end

makefile = get_file_as_string 'Makefile'
File.open("Makefile","w"){ |f| f.puts makefile }
