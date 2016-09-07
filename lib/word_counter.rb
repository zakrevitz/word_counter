require 'word_counter/version'
class NoFileError < StandardError; end
class InvalidUrl < StandardError; end
class TooManyRedirectsError < StandardError; end
module WordCounter
  autoload :Base, 'word_counter/base'
  autoload :Url, 'word_counter/url'

  module Utils
    autoload :Validations, 'word_counter/utils/validations'
  end
end
