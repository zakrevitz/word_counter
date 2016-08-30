module Webmocks
  def stub_example_com
    stub_request(:get, "http://example.com").
          to_return(status: 200,
                    body: local_fixture("example_com.html"),
                    headers: {"Content-Type" => 'text/html'})
  end
end

RSpec.configure do |config|
  config.include Webmocks
end
