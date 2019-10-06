require_relative '../palindrome'
require_relative '../roman_numerals'
require_relative '../parser'
require_relative '../change_maker'
require_relative '../factorial'
require_relative '../fibonacci'
require_relative '../war'
require_relative '../ipolyarea'
require_relative '../almost_increasing'
require_relative '../matrix_element_sum'
require_relative '../reverse_parens'
require_relative '../twelve_days'
require_relative '../chicago'
require_relative '../left_center_right'

# suppress writing to console
RSpec.configure do |config|
  config.before(:each) do
    allow($stdout).to receive(:puts)
    allow($stdout).to receive(:write)
  end
end
