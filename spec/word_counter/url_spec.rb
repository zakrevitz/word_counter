require 'word_counter'
require 'spec_helper'
RSpec.describe WordCounter::Url do
  before :all do
    stub_example_com
  end
  it "should count words on site" do
    word_counter = described_class.from_url('http://example.com')
    expect(word_counter.words).to eq 39
  end

  context 'redirections' do
    before :each do
      stub_redirects_failure
      stub_redirects_success
    end
    it 'should return error if more then one redirection' do
      word_counter = described_class.from_url('http://redirect0.com')
      expect(word_counter.words).to eq 0
      expect(word_counter.errors.class).to eq TooManyRedirectsError
    end

    it 'should count words on redirect site' do
      word_counter = described_class.from_url('http://redirect.success.com')
      expect(word_counter.words).to eq 39
    end
  end

  context 'invalid' do
    it "should count words on site" do
      word_counter = described_class.from_url('abirvagl')
      expect(word_counter.words).to eq 0
      expect(word_counter.errors.class).to eq InvalidUrl
    end
  end
end
