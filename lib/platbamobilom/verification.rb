module Platbamobilom
  class Verification
    attr_reader :id
    attr_reader :result
    attr_reader :phone
    attr_reader :signature

    def initialize(id:, result:, phone:, signature:)
      @id        = id
      @result    = result
      @phone     = phone
      @signature = signature
    end

    def verify(secret)
      signing_data  = [id, result, phone].join
      digest        = OpenSSL::Digest.new('sha256')
      hmac          = OpenSSL::HMAC.digest(digest, secret, signing_data)
      our_signature = hmac.unpack('H*').join.upcase

      our_signature == signature
    end
  end
end
