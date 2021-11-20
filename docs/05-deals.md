## Работа со сделками

SDK позволяет создавать сделки, а также получать информацию о них.

Объект сделки `DealResponse` содержит всю информацию о сделке, актуальную на текущий момент времени. 
Он формируется при создании сделки и приходит в ответ на любой запрос, связанный со сделками.

* [Запрос на создание сделки](#Запрос-на-создание-сделки)
* [Запрос на создание сделки через билдер](#Запрос-на-создание-сделки-через-билдер)
* [Получить информацию о сделке](#Получить-информацию-о-сделке)
* [Получить список сделок с фильтрацией](#Получить-список-сделок-с-фильтрацией)

---

### Запрос на создание сделки

[Создание сделки в документации](https://yookassa.ru/developers/api?lang=ruby#create_deal)

Чтобы создать сделку, необходимо создать объект сделки — `DealRequest`. Он позволяет создать сделку, в рамках которой 
необходимо принять оплату от покупателя и перечислить ее продавцу.

В ответ на запрос придет объект сделки - `DealResponse` в актуальном статусе.

```ruby
res = Yookassa.deals.create({
  "type": "safe_deal",
  "fee_moment": "payment_succeeded",
  "metadata": {
    "order_id": "88"
  },
  "description": "SAFE_DEAL PYTHON 123554642-2432FF344R"
})

```
---

### Запрос на создание сделки через билдер

[СоздCание сделки в документации](https://yookassa.ru/developers/api?lang=ruby#create_deal)

Билдер позволяет создать объект сделки — `DealRequest` программным способом, через объекты.

```ruby
builder = DealRequestBuilder() \
  .set_type(DealType.SAFE_DEAL) \
  .set_fee_moment(FeeMoment.PAYMENT_SUCCEEDED) \
  .set_description('SAFE_DEAL 123554642-2432FF344R') \
  .set_metadata({'order_id': '37'})

request = builder.build()
# Можно что-то поменять, если нужно
request.description = 'SAFE_DEAL PYTHON 123554642-2432FF344R'
res = Yookassa.deals.create(request)
```
---

### Получить информацию о сделке

[Информация о сделке в документации](https://yookassa.ru/developers/api?lang=ruby)

Запрос позволяет получить информацию о текущем состоянии сделки по его уникальному идентификатору.

В ответ на запрос придет объект сделки - `DealResponse` в актуальном статусе.

```ruby
res = Yookassa.deals.find_one('dl-285e5ee7-0022-5000-8000-01516a44b147')
```
---

### Получить список сделок с фильтрацией

[Список сделок в документации](https://yookassa.ru/developers/api?lang=ruby#get_deals_list)

Запрос позволяет получить список сделок, отфильтрованный по заданным критериям.

В ответ на запрос вернется список сделок с учетом переданных параметров. В списке будет информация о сделках, 
созданных за последние 3 года. Список будет отсортирован по времени создания сделок в порядке убывания.

Если результатов больше, чем задано в `limit`, список будет выводиться фрагментами. В этом случае в ответе на запрос 
вернется фрагмент списка и параметр `next_cursor` с указателем на следующий фрагмент.

```ruby
cursor = nil
filters = {
  "limit": 10,                                   # Ограничиваем размер выборки
  "status": "closed",                            # Выбираем только открытые сделки
  "full_text_search": "PYTHON",                  # Фильтр по описанию сделки — параметру description
  "created_at.gte": "2021-08-01T00:00:00.000Z",  # Созданы начиная с 2021-08-01
  "created_at.lt": "2021-11-20T00:00:00.000Z"    # И до 2021-11-20
}

def get_items(filters:, next_cursor: nil, items: [])
  result = Yookassa.deals.list(filters.merge(next_cursor: next_cursor))
  accumulated_items = result.items + items

  return accumulated_items if result.next_cursor.nil?

  get_items(filters: filters, next_cursor: result.next_cursor, items: accumulated_items)
end

get_items(filters: filters, next_cursor: cursor)
```
[Подробнее о работе со списками](https://yookassa.ru/developers/using-api/lists)
