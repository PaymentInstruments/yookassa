# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"

module Yookassa
  module Entity
    class Deal < Dry::Struct
      attribute? :idempotency_key, Types::String
      # id [string, required]
      # Deals's ID in YooMoney
      attribute :id, Types::String

      # Момент перечисления вам вознаграждения платформы. Возможные значения:
      #   payment_succeeded — после успешной оплаты;
      #   deal_closed — при закрытии сделки после успешной выплаты.
      attribute :fee_moment, Types::String.enum("payment_succeeded", "deal_closed")

      # Описание сделки (не более 128 символов). Используется для фильтрации при получении списка сделок.
      attribute? :description, Types::String.constrained(max_size: 128)

      # Баланс сделки.
      attribute :balance, Amount

      # Сумма вознаграждения продавца.
      attribute :payout_balance, Amount

      # Статус сделки. Возможные значения:
      #   opened — сделка открыта; можно выполнять платежи, возвраты и выплаты в составе сделки;
      #   closed — сделка закрыта — вознаграждение перечислено продавцу и платформе или оплата возвращена покупателю;
      #            нельзя выполнять платежи, возвраты и выплаты в составе сделки.
      attribute :status, Types::String.enum("opened", "closed")

      # Время создания сделки. Указывается по UTC и передается в формате ISO 8601. Пример: 2017-11-03T11:52:31.827Z
      attribute :created_at, Types::JSON::DateTime

      # Время автоматического закрытия сделки. Если в указанное время сделка всё еще в статусе opened,
      # ЮKassa вернет деньги покупателю и закроет сделку. По умолчанию время жизни сделки составляет 90 дней.
      # Время указывается по UTC и передается в формате ISO 8601. Пример: 2017-11-03T11:52:31.827Z
      attribute :expires_at, Types::JSON::DateTime

      # metadata [object, optional]
      # Any additional data you might require for processing payments (for example, order number), specified as a “key-value” pair
      # and returned in response from YooMoney.
      # Limitations:
      # - no more than 16 keys,
      # - no more than 32 characters in the key’s title,
      # - no more than 512 characters in the key’s value,
      # - data type is a string in the UTF-8 format.
      attribute? :metadata, Types::Hash

      # Признак тестовой операции.
      attribute :test, Types::Bool
    end
  end
end
