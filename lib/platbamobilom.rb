require 'platbamobilom/version'
require 'platbamobilom/redirect'

module Platbamobilom
  class << self
    attr_accessor :test_mode

    def reset!
      self.test_mode = true
    end
  end
end

Platbamobilom.reset!
