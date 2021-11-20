## Работа с возвратами

С помощью SDK можно возвращать платежи — полностью или частично. Порядок возврата зависит от способа оплаты 
(`payment_method`) исходного платежа. При оплате банковской картой деньги возвращаются на карту, 
которая была использована для проведения платежа. [Как проводить возвраты](https://yookassa.ru/developers/payments/refunds) 

Часть способов оплаты (например, наличные) не поддерживают возвраты. [Какие платежи можно вернуть](https://yookassa.ru/developers/payment-methods/overview#all)

* [Запрос на создание возврата](#Запрос-на-создание-возврата)
* [Запрос на создание возврата через билдер](#Запрос-на-создание-возврата-через-билдер)
* [Получить информацию о возврате](#Получить-информацию-о-возврате)
* [Получить список возвратов с фильтрацией](#Получить-список-возвратов-с-фильтрацией)

---

### Запрос на создание возврата

[Создание возврата в документации](https://yookassa.ru/developers/api?lang=ruby#create_refund)

Создает возврат успешного платежа на указанную сумму. Платеж можно вернуть только в течение трех лет с момента его создания. 
Комиссия ЮKassa за проведение платежа не возвращается.

В ответ на запрос придет объект возврата - `Refund` в актуальном статусе.

```ruby
res = Yookassa.refunds.create({
  "payment_id": "24e89cb0-000f-5000-9000-1de77fa0d6df",
  "description": "Не подошел размер",
  "amount": {
    "value": "9000.00",
    "currency": "RUB"
  },
  "sources": [
    {
      "account_id": "456",
      "amount": {
        "value": "9000.00",
        "currency": "RUB"
      }
    }
  ]
})

```

---

### Запрос на создание возврата через билдер

[Информация о создании возврата в документации](https://yookassa.ru/developers/api?lang=ruby#create_refund)

Билдер позволяет создать объект платежа — `RefundRequest` программным способом, через объекты.

```ruby
builder = RefundRequestBuilder()
builder.set_payment_id('24e89cb0-000f-5000-9000-1de77fa0d6df') \
  .set_description("Не подошел размер") \
  .set_amount({"value": 9000.0, "currency": Currency.RUB}) \
  .set_sources([
    RefundSource({
      'account_id': 456,
      'amount': {
        'value': 9000.0,
        'currency': Currency.RUB
      },
      "platform_fee_amount": {
        "value": 10.01,
        "currency": Currency.RUB
      }
    })
  ])

request = builder.build()
# Можно что-то поменять, если нужно
request.description = "Не подошел цвет и размер"

res = Yokassa.refunds.create(request)
```

---

### Получить информацию о возврате

[Информация о возврате в документации](https://yookassa.ru/developers/api?lang=ruby#get_refund)

Запрос позволяет получить информацию о текущем состоянии возврата по его уникальному идентификатору.

В ответ на запрос придет объект возврата - `Refund` в актуальном статусе.

```ruby
res = Yookassa.refunds.find(refund_id: "7894e5e2-a22e-434b-b6c1-e355ff096d1c")
```

---

### Получить список возвратов с фильтрацией

[Список возвратов в документации](https://yookassa.ru/developers/api?lang=ruby#get_refunds_list)

Запрос позволяет получить список возвратов, отфильтрованный по заданным критериям.

В ответ на запрос вернется список возвратов с учетом переданных параметров. В списке будет информация о возвратах,
созданных за последние 3 года. Список будет отсортирован по времени создания возвратов в порядке убывания.

Если результатов больше, чем задано в `limit`, список будет выводиться фрагментами. В этом случае в ответе на запрос
вернется фрагмент списка и параметр `next_cursor` с указателем на следующий фрагмент.

```ruby
cursor = nil
filters = {
  "limit": 2,                                            # Ограничиваем размер выборки
  "payment_id": "21b23b5b-000f-5061-a000-0674e49a8c10",  # Выбираем только по конкретному платежу
  "created_at.gte": "2020-08-08T00:00:00.000Z",          # Созданы начиная с 2020-08-08
  "created_at.lt": "2020-10-20T00:00:00.000Z"            # И до 2020-10-20
}

def get_items(filters:, next_cursor: nil, items: [])
  result = Yookassa.refunds.list(filters.merge(next_cursor: next_cursor))
  accumulated_items = result.items + items

  return accumulated_items if result.next_cursor.nil?

  get_items(filters: filters, next_cursor: result.next_cursor, items: accumulated_items)
end

get_items(filters: filters, next_cursor: cursor)
```
[Подробнее о работе со списками](https://yookassa.ru/developers/using-api/lists)
