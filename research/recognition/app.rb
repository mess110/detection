require 'fileutils'

class TrainingData
  attr_accessor :pics

  TRAINING_FILE = 'train.txt'

  def initialize
    @pics = []
    File.open(TRAINING_FILE, 'r') do |f|
      while line = f.gets
        parse_and_add(line)
      end
    end
  end

  def count_subjects
    count = 0
    unique = []
    @pics.each do |p|
      if !unique.include?(p[:id])
        count = count + 1;
        unique << p[:id]
      end
    end
    count
  end

  def add_subject
    system("./detectface")

    new_subject_id = count_subjects + 1
    Dir.mkdir("people") unless File.exists?("people")
    Dir.mkdir("people/s#{new_subject_id}") unless File.exists?("people/s#{new_subject_id}")

    Dir["./people/*.pgm"].each do |pic|
      dest = "people/s#{new_subject_id}/"
      FileUtils.mv(pic, dest)
    end

    File.open(TRAINING_FILE, 'a') do |f|
      Dir["people/s#{new_subject_id}/*.pgm"].each do |pic|
        f.puts "#{new_subject_id} #{pic}"
      end
    end
  end

  def parse_and_add(s)
    details = s.split(" ")
    @pics << {
      :id       => details[0],
      :pic_path => details[1]
    }
  end
end

samples = TrainingData.new

if ARGV[0] == "new"
  samples.add_subject
else
  puts "--help\n"
  puts " new - add a new subject"
end
