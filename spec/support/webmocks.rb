module Webmocks
  def stub_example_com
    stub_request(:get, 'http://example.com').
          to_return(status: 200,
                    body: local_fixture('example_com.html'),
                    headers: {'Content-Type' => 'text/html'})
  end

  def stub_redirects_failure
    stub_request(:get, "http://redirect0.com").
            to_return(status: 301,
                      headers: { 'Location' => "http://redirect1.com" }
                      )
    2.times do |i|
      stub_request(:get, "http://redirect#{i}.com").
            to_return(status: 301,
                      headers: { 'Location' => "http://redirect#{i+1}.com" }
                      )
    end
  end

  def stub_redirects_success
    stub_request(:get, 'http://redirect.success.com/').
          to_return(status: 301,
                    headers: { 'Location' => 'http://redirect.success2.com' }
                    )
    stub_request(:get, 'http://redirect.success2.com').
          to_return(status: 200,
                    body: local_fixture('example_com.html'),
                    headers: {'Content-Type' => 'text/html'})
  end
end

RSpec.configure do |config|
  config.include Webmocks
end
