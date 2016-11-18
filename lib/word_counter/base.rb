require 'yomu'
module WordCounter
  class Base
    SPLITTER = ' '.freeze
    REMOVE_SPACE = ''.freeze

    attr_accessor :words, :errors

    def initialize
      @words = 0
      @errors = {}
    end

    class << self
      def from_file(filepath)
        begin
          yomu = Yomu.new filepath
          # TODO: Do something with large TXT files
          # if yomu.mimetype.content_type == 'text/plain'
            # word_counter = from_text(File.read(filepath).force_encoding("UTF-8"))
          # else
            yomu.text.force_encoding("UTF-8")
            word_counter = from_text(yomu.text)
        rescue Exception => e
          word_counter = new
          word_counter.errors = e
        end
        word_counter
      end

      def from_text(text)
        word_counter = new
        if text.empty?
          word_counter.errors[:text] = 'Text is empty'
          return word_counter
        end
        begin
          word_counter.count_words(text)
        rescue Exception => e
          word_counter.errors = e
        end
        word_counter
      end
    end

    def count_words(text)
      clean_text = sanitize(text)
      @words = count(clean_text)
      @words += 1 if clean_text.length > 0
      @words
    end

    private

    def sanitize(text)
      ## Firstly remove all special-whitespaces
      ## Secondly convert multiply whitespaces into one
      ## Thirdly, fourthly - remove trailing whitespaces

      text.gsub(/[\u2000-\u2013\u2015-\u2018\u201A-\u206F\u2E00-\u2E7F\\!"#$%&\(\)*+\r\n\t,\.\/:;<=>?\[\]^_{|}~\uFF0C\u3002]+/, SPLITTER)
          .gsub(/(\s|\u00A0){2,}/, SPLITTER)
          .gsub(/^\s*/, REMOVE_SPACE)
          .gsub(/\s*$/, REMOVE_SPACE)
    end

    def count(text)
      text.count(SPLITTER)
    end
  end
end
