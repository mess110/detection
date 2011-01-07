require 'socket'
require 'digest/md5'
require 'fileutils'

module Spoc
  class FileTransfer

    FILE_TRANSFER_COMPLETE = "it_ain't_over_till_the_fat_lady_sings\n"

    def self.server(port, image_dir)
      FileUtils.mkdir(image_dir) unless File.exists? image_dir

      server = TCPServer.open(port)
      loop {
        Thread.start(server.accept) do |client|
          begin
            client_file = ""
            while (line = client.gets)
              if line == FILE_TRANSFER_COMPLETE
                break
              end
              client_file += line
            end
            file_path = get_file_path(image_dir)
            Spoc::FileConvert.decode(client_file, file_path)
          	client.puts file_path
          ensure
            client.close
          end
        end
      }
    end
    
    def self.client(host, port, file_path)
      begin
        file = Spoc::FileConvert.encode(file_path)
        s = TCPSocket.open(host, port)
        s.puts file
        s.puts FILE_TRANSFER_COMPLETE
        while line = s.gets
          puts line
        end
      ensure
        s.close
      end
    end

  private
  
  def self.get_file_path(image_dir)
    File.join(image_dir, Digest::MD5.hexdigest(Time.now.to_s))
  end
  end
end
