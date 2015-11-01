require "rspec"
require "sentient"

RSpec.configure do |config|
  config.color = true
  config.formatter = :doc
  config.disable_monkey_patching!
end
