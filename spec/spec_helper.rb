$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'afr_load'

RSpec.configure do |c|
    c.fail_fast = true
end
