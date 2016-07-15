desc "Launch Rspec tests"
task :test do |task|
  system("rspec spec")
end
