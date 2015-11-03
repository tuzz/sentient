require "rspec"
require "pry"
require "sentient"

RSpec.configure do |config|
  config.color = true
  config.formatter = :doc
  config.disable_monkey_patching!

  config.before do
    Sentient::Register.reset
  end
end
