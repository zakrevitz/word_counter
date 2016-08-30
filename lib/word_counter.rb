require 'word_counter/version'
class NoFileError < StandardError; end
class InvalidUrl < StandardError; end
module WordCounter
  autoload :Base, 'word_counter/base'
  autoload :Url, 'word_counter/url'
end
