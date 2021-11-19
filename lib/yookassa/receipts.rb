# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/receipt"
require_relative "./entity/collection"

module Yookassa
  class Receipts < Client
    def find(receipt_id:)
      data = get("receipts/#{receipt_id}")
      Entity::Receipt.new(**data)
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = post("receipts", payload: payload, idempotency_key: idempotency_key)
      Entity::Receipt.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list(filters: {})
      data = get("receipts", query: filters)
      Entity::ReceiptCollection.new(**data)
    end
  end
end
