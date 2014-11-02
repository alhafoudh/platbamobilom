module Platbamobilom
  class Redirect
    PRODUCTION_URL = 'https://pay.platbamobilom.sk/pay/'.freeze
    TEST_URL       = 'https://pay.platbamobilom.sk/test/'.freeze

    def self.production_url; PRODUCTION_URL end
    def self.test_url; TEST_URL end
    def self.url; (Platbamobilom.test_mode ? test_url : production_url) end

    attr_reader :pid
    attr_reader :id
    attr_reader :desc
    attr_reader :price
    attr_reader :url
    attr_reader :email

    def initialize(pid:, id:, desc:, price:, url:, email:)
      @pid   = pid
      @id    = id
      @desc  = desc
      @price = price
      @url   = url
      @email = email
    end

    def sign(secret)
      signing_data  = [pid, id, desc, price, url, email].join
      digest        = OpenSSL::Digest.new('sha256')
      hmac          = OpenSSL::HMAC.digest(digest, secret, signing_data)
      signature     = hmac.unpack('H*').join.upcase
    end

    def signed_query_string(signature)
      Rack::Utils.build_query({
        PID: pid,
        ID: id,
        DESC: desc,
        PRICE: price,
        URL: url,
        EMAIL: email,
        SIGN: signature
      })
    end

    def signed_url(signature)
      '%s?%s' % [self.class.url, signed_query_string(signature)]
    end
    
  end
end
