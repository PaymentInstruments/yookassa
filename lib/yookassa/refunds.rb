# frozen_string_literal: true

require_relative "./entity/refund"

module Yookassa
  class Refunds
    def initialize(api)
      @api = api
    end

    def find(payment_id:)
      data = api.get("refunds/#{payment_id}")
      Entity::Refund.new(**data)
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = api.post("refunds", payload: payload, idempotency_key: idempotency_key)
      Entity::Refund.new(**data.merge(idempotency_key: idempotency_key))
    end

    private

    attr_reader :api
  end
end
