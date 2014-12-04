class Sekken
  class Resolver

    URL_PATTERN = /^http[s]?:/
    XML_PATTERN = /^</

    def initialize(http, base_file_path=nil)
      @http = http
      @base_file_path = base_file_path
    end

    def resolve(location)
      case location
        when URL_PATTERN then @http.get(location)
        when XML_PATTERN then location
        else
          begin
            File.read(location)
          rescue
            File.read(File.join(@base_file_path, location))
          end
      end
    end

  end
end
