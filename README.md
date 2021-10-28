# YooKassa API Ruby Client

[![Yookassa](https://github.com/PaymentInstruments/yookassa/actions/workflows/main/badge.svg)](https://github.com/PaymentInstruments/yookassa)
[![Gem Version][gem-badger]][gem]
[![License](https://img.shields.io/github/license/paderinandrey/yookassa.svg)](https://github.com/paderinandrey/yookassa)


[gem-badger]: https://img.shields.io/gem/v/yookassa.svg?style=flat&color=blue
[gem]: https://rubygems.org/gems/yookassa

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yookassa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yookassa

## Usage

```ruby
# Payment

client = Yookassa::Payment.new(shop_id: 'shop_id', api_key: 'api_key')

payment = {
    amount: {
        value:    100,
        currency: 'RUB'
    },
    capture:      true,
    confirmation: {
        type:       'redirect',
        return_url: return_url
    }
}

client.create(payment: payment)

client.get_payment_info(payment_id: '12345')

client.capture(payment_id: '12345')

client.cancel(payment_id: '12345')

# Refund

client = Yookassa::Refund.new(shop_id: 'shop_id', api_key: 'api_key')

client.create(payload: payload)

client.get_refund_info(payment_id: '12345')


```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/paderinandrey/yookassa/issues)
- Fix bugs and [submit pull requests](https://github.com/paderinandrey/yookassa/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
