require 'minitest_helper'

describe Platbamobilom::Redirect do
  before(:each) do
    Platbamobilom.test_mode = true
  end

  let(:described_class) { Platbamobilom::Redirect }
  let(:subject) do
    described_class.new(
      pid:    '1',
      id:     '445566',
      desc:   'some description',
      price:  '3.10',
      url:    'http://redirect.url',
      email:  'sales@example.com'
    )
  end
  let(:secret) { 'test' }
  let(:signature) { 'AF7E772D957225E8A40E5D77801D095AFD82FBBE600BC9CB9DE06A514621D02F' }
  let(:signed_query_string) { 'PID=1&ID=445566&DESC=some+description&PRICE=3.10&URL=http%3A%2F%2Fredirect.url&EMAIL=sales%40example.com&SIGN=AF7E772D957225E8A40E5D77801D095AFD82FBBE600BC9CB9DE06A514621D02F' }
  let(:signed_url) { '%s?%s' % [described_class.url, signed_query_string] }

  it 'has redirect url for specific environment' do
    assert_equal 'https://pay.platbamobilom.sk/pay/', described_class.production_url
    assert_equal 'https://pay.platbamobilom.sk/test/', described_class.test_url
  end

  it 'initializes with all required parameters' do
    assert_equal subject.pid, '1'
    assert_equal subject.id, '445566'
    assert_equal subject.desc, 'some description'
    assert_equal subject.price, '3.10'
    assert_equal subject.url, 'http://redirect.url'
    assert_equal subject.email, 'sales@example.com'
  end

  it 'signes the parameters correctly' do
    assert_equal signature, subject.sign(secret)
  end

  it 'generates signed query string' do
    assert_equal signed_query_string, subject.signed_query_string(signature)
  end

  it 'generates signed url' do
    assert_equal signed_url, subject.signed_url(signature)
  end

  it 'has different url based on test mode' do
    Platbamobilom.test_mode = true
    assert_equal described_class.test_url, described_class.url

    Platbamobilom.test_mode = false
    assert_equal described_class.production_url, described_class.url
  end
end
