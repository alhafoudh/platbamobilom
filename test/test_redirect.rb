require 'minitest_helper'

describe Platbamobilom::Redirect do
  before(:each) do
    Platbamobilom.test_mode = true
  end

  let(:described_class) { Platbamobilom::Redirect }
  let(:subject) do
    described_class.new(
      pid:    'some pid',
      id:     'some id',
      desc:   'some description',
      price:  '3.10',
      url:    'http://redirect.url/',
      email:  'sales@example.com'
    )
  end
  let(:secret) { 'a83592a4ba3bab05417e701309832fee0b1c51271c2ac3e0a55c25cfb447e024' }
  let(:signature) { 'A47893A32EA3E887AAEA21CDFE0EB24863EC5F6E4C28E0D210EFE30A6C4FE606' }

  it 'has redirect url for specific environment' do
    assert_equal 'https://pay.platbamobilom.sk/pay/', described_class.production_url
    assert_equal 'https://pay.platbamobilom.sk/test/', described_class.test_url
  end

  it 'initializes with all required parameters' do
    assert_equal subject.pid, 'some pid'
    assert_equal subject.id, 'some id'
    assert_equal subject.desc, 'some description'
    assert_equal subject.price, '3.10'
    assert_equal subject.url, 'http://redirect.url/'
    assert_equal subject.email, 'sales@example.com'
  end

  it 'signes the parameters correctly' do
    assert_equal signature, subject.sign(secret)
  end

  it 'has different url based on test mode' do
    Platbamobilom.test_mode = true
    assert_equal described_class.test_url, described_class.url

    Platbamobilom.test_mode = false
    assert_equal described_class.production_url, described_class.url
  end
end
