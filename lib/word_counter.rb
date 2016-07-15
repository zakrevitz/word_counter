require 'word_counter/version'
class NoFileError < StandardError; end
module WordCounter
  autoload :Base, 'word_counter/base'
end
