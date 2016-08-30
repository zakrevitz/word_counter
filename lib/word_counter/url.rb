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
        raise InvalidUrl, 'Invalid url. Re-check entered value!' if url.empty?
        # begin
          http = Net::HTTP.new url, 80
          request = Net::HTTP::Get.new '/'
          response = http.request request
          raise InvalidUrl, 'Invalid url. Re-check entered value!' unless response_valid?(response)
          word_counter = from_text(sanitize_html(response.body))
        # rescue Exception => e
          # word_counter = new
          # word_counter.errors = e
        # end
        word_counter
      end


      private
      def sanitize_html(html)
        Sanitize.fragment(html,
          remove_contents: ['style', 'script'],
          elements: ['meta'],
          attributes: { 'meta' => ['content'] },
          transformers: @@meta_whitelist_transformer
          )
      end

      def response_valid?(response)
        response.content_type == 'text/html' && response.code.to_i == 200
      end
    end
  end
end
