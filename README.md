# platbamobilom

This gem provides a set of helpers to generate and verify signatures of [platbamobilom.sk](http://www.platbamobilom.sk) service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'platbamobilom'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install platbamobilom

## Usage


```ruby
# Generate signature

secret = 'test'

redirect = Platbamobilom::Redirect.new(
  pid:    '1',
  id:     '445566',
  desc:   'some description',
  price:  '3.10',
  url:    'http://redirect.url',
  email:  'sales@example.com'
)

signature = redirect.sign(secret) # => 'AF7E772D957225E8A40E5D77801D095AFD82FBBE600BC9CB9DE06A514621D02F'

# Generate signed URL

redirect.signed_url(signature) # => 'https://pay.platbamobilom.sk/test/?PID=1&ID=445566&DESC=some+description&PRICE=3.10&URL=http%3A%2F%2Fredirect.url&EMAIL=sales%40example.com&SIGN=AF7E772D957225E8A40E5D77801D095AFD82FBBE600BC9CB9DE06A514621D02F'
```

## Contributing

1. Fork it ( https://github.com/alhafoudh/platbamobilom/fork )
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request
