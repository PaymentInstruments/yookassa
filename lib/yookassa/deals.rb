# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/deal"
require_relative "./entity/collection"

module Yookassa
  class Deals < Client
    def find(deal_id:)
      data = get("deals/#{deal_id}")
      Entity::Deal.new(**data)
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = post("deals", payload: payload, idempotency_key: idempotency_key)
      Entity::Deal.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list
      data = get("deals")
      Entity::DealCollection.new(**data)
    end
  end
end
