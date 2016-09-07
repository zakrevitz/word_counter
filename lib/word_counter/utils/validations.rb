module WordCounter
  module Utils
    class Validations
      class << self
        def valid_response?(response)
          response.content_type == 'text/html' && response.is_a?(Net::HTTPSuccess)
        end

        def valid_url?(url)
          return true if url =~ URI::ABS_URI
          false
        end
      end
    end
  end
end
