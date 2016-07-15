require 'rake/testtask'

desc "Launch Rspec tests"
task :test do |task|
  system("rspec spec")
end


desc "Test file"
task :test_file, [:arg] do |task, args|
  puts "Counting..."
  require './lib/word_counter/base.rb'
  words = WordCounter::Base.new(args[:arg]).words_count
  puts "File '#{args[:arg]}' has #{words} words"
end
