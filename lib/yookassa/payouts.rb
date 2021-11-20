# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/payout"
require_relative "./entity/collection"

module Yookassa
  class Payouts < Client
    def find(payout_id:)
      data = get("payouts/#{payout_id}")
      Entity::Payout.new(**data)
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = post("payouts", payload: payload, idempotency_key: idempotency_key)
      Entity::Payout.new(**data.merge(idempotency_key: idempotency_key))
    end
  end
end
