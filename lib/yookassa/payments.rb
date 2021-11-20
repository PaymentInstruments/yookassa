# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/payment"
require_relative "./entity/collection"

module Yookassa
  class Payments < Client
    def find(payment_id:)
      data = get("payments/#{payment_id}")
      Entity::Payment.new(**data)
    end

    def create(payment:, idempotency_key: SecureRandom.hex(10))
      data = post("payments", payload: payment, idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def capture(payment_id:, idempotency_key: SecureRandom.hex(10))
      data = post("payments/#{payment_id}/capture", idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def cancel(payment_id:, idempotency_key: SecureRandom.hex(10))
      data = post("payments/#{payment_id}/cancel", idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list(filters: {})
      data = get("payments", query: filters)
      Entity::PaymentCollection.new(**data)
    end
  end
end
