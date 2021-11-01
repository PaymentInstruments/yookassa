# frozen_string_literal: true

require_relative "./entity/payment"

module Yookassa
  class Payments
    def initialize(api)
      @api = api
    end

    def find(payment_id:)
      data = api.get("payments/#{payment_id}")
      Entity::Payment.new(**data)
    end

    def create(payment:, idempotency_key: SecureRandom.hex(10))
      data = api.post("payments", payload: payment, idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def capture(payment_id:, idempotency_key: SecureRandom.hex(10))
      data = api.post("payments/#{payment_id}/capture", idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def cancel(payment_id:, idempotency_key: SecureRandom.hex(10))
      data = api.post("payments/#{payment_id}/cancel", idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    private

    attr_reader :api
  end
end
