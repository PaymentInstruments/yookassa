# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/refund"
require_relative "./entity/collection"

module Yookassa
  class Refunds < Client
    def find(payment_id:)
      data = get("refunds/#{payment_id}")
      Entity::Refund.new(**data)
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = post("refunds", payload: payload, idempotency_key: idempotency_key)
      Entity::Refund.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list(filters: {})
      data = get("refunds", query: filters)
      Entity::RefundCollection.new(**data)
    end
  end
end
