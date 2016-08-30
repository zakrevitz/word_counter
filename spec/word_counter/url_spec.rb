require 'word_counter'
require 'spec_helper'
RSpec.describe WordCounter::Url do
  before :all do
    stub_example_com
  end
  it "should count words in doc file" do
    word_counter = described_class.from_url('example.com')
    expect(word_counter.words).to eq 39
  end
end
