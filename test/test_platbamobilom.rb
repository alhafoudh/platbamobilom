require 'minitest_helper'

describe Platbamobilom do
  before(:each) do
    Platbamobilom.reset!
  end

  it 'has a version number' do
    refute_nil ::Platbamobilom::VERSION
  end

  it 'is in test mode as default' do
    assert_equal true, Platbamobilom.test_mode
  end

  it 'can disable test mode' do
    assert_equal true, Platbamobilom.test_mode

    Platbamobilom.test_mode = false

    assert_equal false, Platbamobilom.test_mode
  end
end
