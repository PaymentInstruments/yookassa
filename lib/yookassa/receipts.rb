# frozen_string_literal: true

require_relative "./entity/receipt"
require_relative "./entity/collection"

module Yookassa
  class Receipts
    def initialize(api)
      @api = api
    end

    def find(receipt_id:)
      data = api.get("receipts/#{receipt_id}")
      Entity::Receipt.new(**data)
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = api.post("receipts", payload: payload, idempotency_key: idempotency_key)
      Entity::Receipt.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list(filters: {})
      data = api.get("receipts", query: filters)
      Entity::ReceiptCollection.new(**data)
    end

    private

    attr_reader :api
  end
end
