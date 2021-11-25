## Работа с выплатами

SDK позволяет создавать, подтверждать, отменять выплаты, а также получать информацию о них.

Объект выплаты `PayoutResponse` содержит всю информацию о выплате, актуальную на текущий момент времени. 
Он формируется при создании выплаты и приходит в ответ на любой запрос, связанный с выплатами.

* [Запрос на создание выплаты](#Запрос-на-создание-выплаты)
* [Запрос на создание выплаты через билдер](#Запрос-на-создание-выплаты-через-билдер)
* [Получить информацию о выплате](#Получить-информацию-о-выплате)

---

### Запрос на создание выплаты

[Создание выплаты в документации](https://yookassa.ru/developers/api?lang=ruby#create_payout)

Чтобы принять оплату, необходимо создать объект выплаты — `PayoutRequest`. Он содержит всю необходимую информацию 
для проведения оплаты (сумму, валюту и статус). У выплаты линейный жизненный цикл, 
он последовательно переходит из статуса в статус.

В ответ на запрос придет объект выплаты - `PayoutResponse` в актуальном статусе.

```ruby
res = Yookassa.payouts.create({
  "amount": {"value": 320.0, "currency": Currency.RUB},
  "payout_destination_data": {'type': PaymentMethodType.YOO_MONEY, 'account_number': '41001614575714'},
  "description": "Выплата по заказу №37",
  "metadata": {
     "order_id": "37"
  },
  "deal": {
    "id": "dl-285e5ee7-0022-5000-8000-01516a44b147"
  }
})
```
---

### Запрос на создание выплаты через билдер

[Создание выплаты в документации](https://yookassa.ru/developers/api?lang=ruby#create_payout)

Билдер позволяет создать объект выплаты — `PayoutRequest` программным способом, через объекты.

```ruby

builder = PayoutRequestBuilder()
builder.set_amount({'value': 0.1, 'currency': Currency.RUB}) \
  .set_description('Выплата по заказу №77') \
  .set_payout_token('99091209012') \
  .set_metadata({'order_id': '77'}) \
  .set_deal({
    'id': 'dl-285e5ee7-0022-5000-8000-01516a44b147'
  })
  
request = builder.build()
# Можно что-то поменять, если нужно
request.description = 'Выплата по заказу №77'
res = Yookassa.payouts.create(request)
```
---

### Получить информацию о выплате

[Информация о выплате в документации](https://yookassa.ru/developers/api?lang=ruby#get_payout)

Запрос позволяет получить информацию о текущем состоянии выплаты по его уникальному идентификатору.

В ответ на запрос придет объект выплаты в актуальном статусе.

```ruby
res = Yookassa.payouts.find_one('po-21b23b5b-000f-5061-a000-0674e49a8c10')
```