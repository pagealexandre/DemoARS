module SpecHelpers
  # Database time rounds to the nearest millisecond, so for comparison its
  # easiest to use this method instead
  def current_time
    Time.zone.now.change(usec: 0)
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end