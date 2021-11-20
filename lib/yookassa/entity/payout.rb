# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"
require_relative "./payout_destinations"

module Yookassa
  module Entity
    class Payout < Dry::Struct
      attribute? :idempotency_key, Types::String
      # id [string, required]
      # Deals's ID in YooMoney
      attribute :id, Types::String

      # Сумма выплаты
      attribute :amount, Amount

      # Статус выплаты. Возможные значения:
      #   pending — только для выплат на банковские карты: выплата создана и ожидает подтверждения от эмитента,
      #             что деньги можно перевести на указанную банковскую карту;
      #   succeeded — выплата успешно завершена, оплата переведена на платежное средство продавца
      #               (финальный и неизменяемый статус);
      #   canceled — выплата отменена, инициатор и причина отмены указаны в объекте cancellation_details
      #               (финальный и неизменяемый статус).
      attribute :status, Types::String.enum("pending", "succeeded", "canceled")

      attribute :payout_destination, PayoutDestinations

      # Описание сделки (не более 128 символов). Используется для фильтрации при получении списка сделок.
      attribute? :description, Types::String.constrained(max_size: 128)

      # Время создания сделки. Указывается по UTC и передается в формате ISO 8601. Пример: 2017-11-03T11:52:31.827Z
      attribute :created_at, Types::JSON::DateTime

      # Сделка, в рамках которой нужно провести выплату. Присутствует, если вы проводите Безопасную сделку
      attribute? :deal do
        # Идентификатор сделки.
        attribute :id, Types::String
      end

      # Комментарий к статусу canceled: кто отменил выплату и по какой причине.
      attribute? :cancellation_details do
        # Участник процесса выплаты, который принял решение об отмене транзакции. Может принимать значения
        # yoo_money, payment_network и merchant https://yookassa.ru/developers/solutions-for-platforms/safe-deal/integration/payouts#declined-payouts-cancellation-details-party
        attribute? :party, Types::String.enum("yoo_money", "payment_network", "merchant")

        # Причина отмены выплаты
        #   fraud_suspected Выплата заблокирована из-за подозрения в мошенничестве
        #   general_decline Причина не детализирована. Пользователю следует обратиться к инициатору отмены выплаты за уточнением подробностей
        #   one_time_limit_exceeded Превышен лимит на разовое зачисление. Подробнее о лимитах
        #   periodic_limit_exceeded Превышен лимит выплат за период времени (сутки, месяц). Подробнее о лимитах
        #   rejected_by_payee Эмитент отклонил выплату по неизвестным причинам
        attribute :reason,
                  Types::String.enum("fraud_suspected", "general_decline", "one_time_limit_exceeded", "periodic_limit_exceeded", "rejected_by_payee")
      end

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
