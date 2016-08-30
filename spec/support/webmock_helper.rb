module WebmockHelper
  def local_fixture(file)
    # File.read(Rails.root.join('spec/factories/webmocks', file))
    File.read(File.join(File.expand_path('../../webmocks', __FILE__), file))
  end
end

RSpec.configure { |c| c.include WebmockHelper }
