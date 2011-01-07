require 'socket'
require 'tempfile'
require 'digest/md5'

module Spoc
  class FileTransfer

    FILE_TRANSFER_COMPLETE = "it_ain't_over_till_the_fat_lady_sings\n"

    def self.server(port)
      server = TCPServer.open(port)
      loop {
        Thread.start(server.accept) do |client|
          client_file = ""
          while (line = client.gets)
            if line == FILE_TRANSFER_COMPLETE
              break
            end
            client_file += line
          end
          tmp = Tempfile.new(Digest::MD5.hexdigest(Time.now.to_s))

          Spoc::FileConvert.decode(client_file, tmp.path)
          tmp.flush
          tmp.close
        	client.puts tmp.path
          client.close  
        end
      }
    end
    
    def self.client(host, port, file_path)
      file = Spoc::FileConvert.encode(file_path)
      s = TCPSocket.open(host, port)
      s.puts file
      s.puts FILE_TRANSFER_COMPLETE
      while line = s.gets
        puts line
      end
      s.close
    end
  end
end
