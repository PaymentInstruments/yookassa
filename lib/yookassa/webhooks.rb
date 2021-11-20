# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/webhook"
require_relative "./entity/collection"

module Yookassa
  class Webhooks < Client
    def create(payload:, idempotency_key: SecureRandom.hex(10))
      data = post("webhooks", payload: payload, idempotency_key: idempotency_key)
      Entity::Webhook.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list
      data = get("webhooks")
      Entity::WebhookCollection.new(**data)
    end

    def delete(webhook_id:)
      delete("webhooks/#{webhook_id}")
      true
    end
  end
end
