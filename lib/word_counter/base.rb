require 'yomu'
module WordCounter
  class Base
    attr_accessor :words_count, :errors
    def initialize(filepath)
      @filepath = filepath
      @words_count = 0
      @errors = {}
      raise NoFileError, "File does not exist!" unless File.exist?(@filepath)
      if @filepath =~ /\.txt$/
        count_words_txt
      else
        count_words
      end
      @words_count
    end

    private
    def count_words_txt
      begin
        lines = File.readlines(@filepath)
        lines.each do |line|
          @words_count += sanitize_and_count(line)
        end
      rescue Exception => e
        @errors = e
        return nil
      end
    end

    def count_words
      begin
        yomu = Yomu.new @filepath
        yomu.text.force_encoding("UTF-8")
        @words_count = sanitize_and_count(yomu.text)
      rescue Exception => e
        @errors = e
        return nil
      end
    end

    def sanitize_and_count(text)
      text.gsub(/[,，。()-.»«]/,' ').split.length
    end
  end
end
