require 'net/https'
require 'sanitize'
module WordCounter
  class Url < Base
    class << self
      @@meta_whitelist_transformer = lambda do |env|
        # Ignore everything except <meta> elements.
        return unless env[:node_name] == 'meta'
        node      = env[:node]
        unless %w{description keywords}.include? node['name']
          node.unlink # `Nokogiri::XML::Node#unlink` removes a node from the document
        else
          node.replace("<div>#{node['content']}</div>") # replace it with simple text to count words in future
        end
      end

      def from_url(url)
        begin
          raise InvalidUrl, 'Invalid url. Re-check entered value!' unless valid_url?(url)
          response = fetch(url)
          raise InvalidUrl, 'Invalid url. Re-check entered value!' unless response_valid?(response)
          word_counter = from_text(sanitize_html(response.body))
        rescue Exception => e
          word_counter = new
          word_counter.errors = e
        end
        word_counter
      end


      private
      def sanitize_html(html)
        WordCounter::Utils::Sanitizer.sanitize_html(html)
      end

      def response_valid?(response)
        WordCounter::Utils::Validations.valid_response?(response)
      end

      def valid_url?(url)
        return false if url.empty?
        WordCounter::Utils::Validations.valid_url?(url)
      end

      def fetch(uri_str, limit = 1)
        # TODO: Choose better error handling
        raise TooManyRedirectsError, 'Too many redirects!' if limit < 0

        response = Net::HTTP.get_response(URI(uri_str))

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response['location']
          fetch(location, limit - 1)
        else
          response.value
        end
      end
    end
  end
end
