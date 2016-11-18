module WordCounter
  module Utils
    class Sanitizer
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

        def sanitize_html(html)
          Sanitize.fragment(html,
            remove_contents: ['style', 'script'],
            elements: ['meta'],
            attributes: { 'meta' => ['content'] },
            transformers: @@meta_whitelist_transformer
            )
        end
      end
    end
  end
end
