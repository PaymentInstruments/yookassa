# YooKassa API Ruby Client
[![Github Actions](https://github.com/PaymentInstruments/yookassa/actions/workflows/main.yml/badge.svg)](https://github.com/PaymentInstruments/yookassa/actions/workflows/main.yml)
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

### Configuration

First of all you need to setup credentials to use Yookassa.
You can configure your instance of Yookassa once in a application booting time. Ex. if you use rails, just put these lines into initializer file

```ruby
# config/initializers/yookassa.rb

Yookassa.configure do |config|
  config.shop_id = ENV.fetch('YOOKASSA_SHOP_ID') # or put your shop_id and api_key here directly
  config.api_key = ENV.fetch('YOOKASSA_API_KEY') # can be taken from Rails.credentials too
end
```

There are some cases, when you need to connect to different Yookassa accounts (say, your clients need to connect to Yookassa). That probably means that you run a marketplace or multitenant system. There is a solution for this one from Yookassa, see https://yookassa.ru/en/developers/special-solutions/checkout-for-platforms/basics or https://yookassa.ru/en/developers/partners-api/basics

If that is not your case, and you still have multiple shop_ids and api_keys, and need to handle all of them under one application, then you need to instantiate clients inline

```ruby
client1 = Yookassa::Payments.new(shop_id: 'shop_1', api_key: '123')
client2 = Yookassa::Payments.new(shop_id: 'shop_2', api_key: '456')
```

### Making Payments

#### Creating payment
```ruby
idempotency_key = SecureRandom.hex(10)

payload = {
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

# Just pass a hash as a first argument to the endpoint. Will autovalidate before making a request
payment = Yookassa.payments.create(payload, idempotency_key: idempotency_key)

# or build a PaymentRequest
payment_request = Yookassa::PaymentRequest.new(payload)
payment_request.valid?
payment = Yookassa.payments.create(payment_request, idempotency_key: idempotency_key)

# or use builder to create a payment, specifying parts for payment separately. Will autovalidate before making a request
payment = Yookassa.payments.create(idempotency_key: idempotency_key) do |p|
  p.amount = Money(100, 'RUB')
  p.capture = true
  p.confirmation = { type: 'redirect', return_url: URL }
end


# or

payments = Yookassa::Payments.new(shop_id: 'shop_1', api_key: '123')
payment = payments.create(payment: payload)
```

#### Other payment requests

```ruby
Yookassa.payments.find(payment_id: '12345')
Yookassa.payments.capture(payment_id: '12345')
Yookassa.payments.cancel(payment_id: '12345')
```

### Path to 1.0

#### [Настройки SDK API ЮKassa](01-configuration.md)
 - [x] [Аутентификация](01-configuration.md#Аутентификация)
 - [ ] [Статистические данные об используемом окружении](01-configuration.md#Статистические-данные-об-используемом-окружении)
 - [x] [Получение информации о магазине](01-configuration.md#Получение-информации-о-магазине)
 - [x] [Работа с Webhook](01-configuration.md#Работа-с-Webhook)
 - [x] [Входящие уведомления](01-configuration.md#Входящие-уведомления)

#### [Работа с платежами](02-payments.md)
 - [x] [Запрос на создание платежа](02-payments.md#Запрос-на-создание-платежа)
 - [ ] [Запрос на создание платежа через билдер](02-payments.md#Запрос-на-создание-платежа-через-билдер)
 - [x] [Запрос на частичное подтверждение платежа](02-payments.md#Запрос-на-частичное-подтверждение-платежа)
 - [x] [Запрос на отмену незавершенного платежа](02-payments.md#Запрос-на-отмену-незавершенного-платежа)
 - [x] [Получить информацию о платеже](02-payments.md#Получить-информацию-о-платеже)
 - [ ] [Получить список платежей с фильтрацией](02-payments.md#Получить-список-платежей-с-фильтрацией)
 - [ ] Контракт на добавление платежа
 - [ ] Запись реальных валидных и невалидных запросов и ответов

#### [Работа с возвратами](03-refunds.md)
 - [x] [Запрос на создание возврата](03-refunds.md#Запрос-на-создание-возврата)
 - [ ] [Запрос на создание возврата через билдер](03-refunds.md#Запрос-на-создание-возврата-через-билдер)
 - [x] [Получить информацию о возврате](03-refunds.md#Получить-информацию-о-возврате)
 - [x] [Получить список возвратов с фильтрацией](03-refunds.md#Получить-список-возвратов-с-фильтрацией)
 - [ ] Контракт на добавление возврата
 - [ ] Запись реальных валидных и невалидных запросов и ответов

#### [Работа с чеками](04-receipts.md)
 - [x] [Запрос на создание чека](04-receipts.md#Запрос-на-создание-чека)
 - [ ] [Запрос на создание чека через билдер](04-receipts.md#Запрос-на-создание-чека-через-билдер)
 - [x] [Получить информацию о чеке](04-receipts.md#Получить-информацию-о-чеке)
 - [x] [Получить список чеков с фильтрацией](04-receipts.md#Получить-список-чеков-с-фильтрацией)
 - [ ] Контракт на добавление чека
 - [ ] Запись реальных валидных и невалидных запросов и ответов

#### [Работа со сделками](05-deals.md)
 - [x] [Запрос на создание сделки](05-deals.md#Запрос-на-создание-сделки)
 - [ ] [Запрос на создание сделки через билдер](05-deals.md#Запрос-на-создание-сделки-через-билдер)
 - [x] [Получить информацию о сделке](05-deals.md#Получить-информацию-о-сделке)
 - [x] [Получить список сделок с фильтрацией](05-deals.md#Получить-список-сделок-с-фильтрацией)
 - [ ] Контракт на добавление сделки
 - [ ] Запись реальных валидных и невалидных запросов и ответов

#### [Работа с выплатами](06-payouts.md)
 - [x] [Запрос на создание выплаты](06-payouts.md#Запрос-на-создание-выплаты)
 - [ ] [Запрос на создание выплаты через билдер](06-payouts.md#Запрос-на-создание-выплаты-через-билдер)
 - [x] [Получить информацию о выплате](06-payouts.md#Получить-информацию-о-выплате)
 - [ ] Контракт на добавление выплаты
 - [ ] Запись реальных валидных и невалидных запросов и ответов


## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/paderinandrey/yookassa/issues)
- Fix bugs and [submit pull requests](https://github.com/paderinandrey/yookassa/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
