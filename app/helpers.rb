Dir[File.join(File.dirname(__FILE__), 'helpers', '*.rb')].each do |filename|
  require filename
end

module Phogo
  module Helpers
  end
end
