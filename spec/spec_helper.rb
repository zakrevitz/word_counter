require 'webmock/rspec'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each {|file| require file }
end
