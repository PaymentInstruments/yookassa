## Работа с чеками

> Для тех, кто использует [решение ЮKassa для 54-ФЗ](https://yookassa.ru/developers/54fz/basics).

С помощью SDK можно получать информацию о чеках, для которых вы отправили данные через ЮKassa.

* [Запрос на создание чека](#Запрос-на-создание-чека)
* [Запрос на создание чека через билдер](#Запрос-на-создание-чека-через-билдер)
* [Получить информацию о чеке](#Получить-информацию-о-чеке)
* [Получить список чеков с фильтрацией](#Получить-список-чеков-с-фильтрацией)

---

### Запрос на создание чека

[Информация о создании чека в документации](https://yookassa.ru/developers/api?lang=ruby#create_receipt)

Запрос позволяет передать онлайн-кассе данные для формирования [чека зачета предоплаты](https://yookassa.ru/developers/54fz/payments#settlement-receipt).

Если вы работаете по сценарию [Сначала платеж, потом чек](https://yookassa.ru/developers/54fz/basics#receipt-after-payment), 
в запросе также нужно передавать данные для формирования чека прихода и чека возврата прихода.

```ruby
res = Yookassa.receipts.create({
  "customer": {
    "full_name": "Ivanov Ivan Ivanovich",
    "email": "email@email.ru",
    "phone": "+79211234567",
    "inn": "6321341814"
  },
  "payment_id": "24b94598-000f-5000-9000-1b68e7b15f3f",
  "type": "payment",
  "send": true,
  "items": [
    {
      "description": "Наименование товара 1",
      "quantity": 1.000,
      "amount": {
        "value": "14000.00",
        "currency": "RUB"
      },
      "vat_code": "2",
      "payment_mode": "full_payment",
      "payment_subject": "commodity",
      "country_of_origin_code": "CN",
    },
    {
      "description": "Наименование товара 2",
      "quantity": 1.000,
      "amount": {
        "value": "1000.00",
        "currency": "RUB"
      },
      "vat_code": "2",
      "payment_mode": "full_payment",
      "payment_subject": "commodity",
      "country_of_origin_code": "CN",
    },
  ],
  "settlements": [
    {
      "type": "prepayment",
      "amount": {
        "value": "8000.00",
        "currency": "RUB"
      },
    },
    {
      "type": "prepayment",
      "amount": {
        "value": "7000.00",
        "currency": "RUB"
      },
    }
  ]
})
```

---

### Запрос на создание чека через билдер

[Информация о создании чека в документации](https://yookassa.ru/developers/api?lang=ruby#create_receipt)

Билдер позволяет создать объект платежа — `Receipt` программным способом, через объекты.

```ruby

builder = ReceiptRequestBuilder()
builder.set_type(ReceiptType.PAYMENT) \
  .set_payment_id('215d8da0-000f-50be-b000-0003308c89be') \
  .set_customer({'phone': '79990000000', 'email': 'test@email.com'}) \
  .set_tax_system_code(1) \
  .set_items([
    {
      "description": "Product 1",
      "quantity": 2.0,
      "amount": {
        "value": 250.0,
        "currency": Currency.RUB
      },
      "vat_code": 2
    },
    ReceiptItem({
      "description": "Product 2",
      "quantity": 1.0,
      "amount": {
        "value": 100.0,
        "currency": Currency.RUB
      },
      "vat_code": 2
    })
  ]) \
  .set_settlements([
    Settlement({
      'type': SettlementType.CASHLESS,
      'amount': {
        'value': 350.0,
        'currency': Currency.RUB
      }
    })
  ])

request = builder.build()
# Можно что-то поменять, если нужно
request.on_behalf_of = 123456

Yokassa.receipts.create(request)
```

---

### Получить информацию о чеке

[Информация о чеке в документации](https://yookassa.ru/developers/api?lang=ruby#get_receipt)

Запрос позволяет получить информацию о текущем состоянии чека по его уникальному идентификатору.

В ответ на запрос придет объект чека - `Receipt` в актуальном статусе.

```ruby
Yookassa.receipts.find('rt-2da5c87d-0384-50e8-a7f3-8d5646dd9e10')
```

---

### Получить список чеков с фильтрацией

[Список чеков в документации](https://yookassa.ru/developers/api?lang=ruby#get_receipts_list)

Запрос позволяет получить список чеков, отфильтрованный по заданным критериям.
Можно запросить чеки по конкретному платежу, чеки по конкретному возврату или все чеки магазина.

В ответ на запрос вернется список чеков с учетом переданных параметров. В списке будет информация о чеках,
созданных за последние 3 года. Список будет отсортирован по времени создания чеков в порядке убывания.

Если результатов больше, чем задано в `limit`, список будет выводиться фрагментами.
В этом случае в ответе на запрос вернется фрагмент списка и параметр `next_cursor` с указателем на следующий фрагмент.

```ruby
cursor = nil
filters = {
  "limit": 2,                                            # Ограничиваем размер выборки
  "payment_id": "21b23b5b-000f-5061-a000-0674e49a8c10",  # Выбираем только по конкретному платежу
  "created_at.gte": "2020-08-08T00:00:00.000Z",          # Созданы начиная с 2020-08-08
  "created_at.lt": "2020-10-20T00:00:00.000Z"            # И до 2020-10-20
}

def get_items(filters:, next_cursor: nil, items: [])
  result = Yookassa.receipts.list(filters.merge(next_cursor: next_cursor))
  accumulated_items = result.items + items

  return accumulated_items if result.next_cursor.nil?

  get_items(filters: filters, next_cursor: result.next_cursor, items: accumulated_items)
end

get_items(filters: filters, next_cursor: cursor)
```
[Подробнее о работе со списками](https://yookassa.ru/developers/using-api/lists)
