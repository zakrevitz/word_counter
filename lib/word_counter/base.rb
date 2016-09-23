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
          # end
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
      @words = sanitize_and_count(text) + 1
    end

    private

    def sanitize_and_count(text)
      ## Firstly remove all special-whitespaces
      ## Secondly convert multiply whitespaces into one
      ## Thirdly, fourthly - remove trailing whitespaces
      text.gsub(/[\r\n\t,，。()-.»«]/, SPLITTER).gsub(/(\s|\u00A0){2,}/, SPLITTER).gsub(/^\s*/, REMOVE_SPACE).gsub(/\s*$/, REMOVE_SPACE).count(SPLITTER)
    end
  end
end
