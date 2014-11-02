require 'minitest_helper'

describe Platbamobilom::Verification do
  let(:described_class) { Platbamobilom::Verification }
  let(:subject) do
    described_class.new(
      id:        '445566',
      result:    'OK',
      phone:     '421903000000',
      signature: '2FD327601CC033ED60A610EAF1239C5E958774426F6CC1D6B48DE422336784A3'
    )
  end
  let(:bad_subject) do
    described_class.new(
      id:        '445566',
      result:    'FAIL',
      phone:     '421903000000',
      signature: '2FD327601CC033ED60A610EAF1239C5E958774426F6CC1D6B48DE422336784A3'
    )
  end
  let(:secret) { 'test' }

  it 'initializes with all required parameters' do
    assert_equal subject.id, '445566'
    assert_equal subject.result, 'OK'
    assert_equal subject.phone, '421903000000'
    assert_equal subject.signature, '2FD327601CC033ED60A610EAF1239C5E958774426F6CC1D6B48DE422336784A3'
  end

  it 'verifies signature correctly' do
    assert_equal true, subject.verify(secret)
    assert_equal false, bad_subject.verify(secret)
  end
end
