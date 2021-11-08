# frozen_string_literal: true

require_relative "./entity/payment"
require_relative "./entity/collection"
require_relative "./contracts/payment_contract"

module Yookassa
  class Payments
    CreatePaymentError = Class.new(StandardError)

    def initialize(api)
      @api = api
    end

    def find(payment_id:)
      data = api.get("payments/#{payment_id}")
      Entity::Payment.new(**data)
    end

    def create(payment:, idempotency_key: SecureRandom.hex(10))
      # validate_payment(payment)

      data = api.post("payments", payload: payment, idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    rescue CreatePaymentError => e
      e
    end

    def capture(payment_id:, idempotency_key: SecureRandom.hex(10))
      data = api.post("payments/#{payment_id}/capture", idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def cancel(payment_id:, idempotency_key: SecureRandom.hex(10))
      data = api.post("payments/#{payment_id}/cancel", idempotency_key: idempotency_key)
      Entity::Payment.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list(filters: {})
      data = api.get("payments", query: filters)
      Entity::PaymentCollection.new(**data)
    end

    private

    attr_reader :api

    def validate_payment(data)
      contract = Yookassa::Contracts::PaymentContract.new
      result = contract.call(data)
      return if result.success?

      raise CreatePaymentError, result
    end
  end
end
