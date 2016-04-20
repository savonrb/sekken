class Sekken
  class AbstractHttpAdapter
    # @api 1.0
    # @abstract

    # Public: Executes an HTTP GET request to a given url.
    #
    # Returns the raw HTTP response body as a String.
    #
    # @param [String, URI] url
    # @param [Hash<String, String>] headers
    # @return [String] the raw body of the response
    def get(url, headers = {})
      fail NotImplementedError
    end

    # Public: Executes an HTTP POST request to a given url with headers and body.
    #
    # Returns the raw HTTP response body as a String.
    #
    # @param [String, URI] url
    # @param [Hash<String, String>] headers
    # @param [String] body
    # @return [String] the raw body of the response
    def post(url, headers, body)
      fail NotImplementedError
    end
  end
end
