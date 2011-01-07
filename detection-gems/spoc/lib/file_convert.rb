require 'base64'

module Spoc
  class FileConvert
    def self.encode(file_path)
      file = File.open(file_path, "rb")
      contents = file.read
      file.close
      Base64.encode64(contents)
    end

    def self.decode(string, output_file_path)
      decoded = Base64.decode64(string)
      new_file = File.open(output_file_path, "wb")
      new_file.write(decoded)
      new_file.close
    end
  end
end
