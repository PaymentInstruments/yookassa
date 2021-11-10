# frozen_string_literal: true

require_relative './entity/webhook'

module Yookassa
  class Webhooks
    def initialize(partner_api)
      @partner_api = partner_api
    end

    def create(payload::, idempotency_key: SecureRandom.hex(10))
      data = partner_api.post("webhooks", payload: payload, idempotency_key: idempotency_key)
      Entity::Webhook.new(**data.merge(idempotency_key: idempotency_key))
    end

    def list
      data = partner_api.get("webhooks")
      Entity::WebhookCollection.new(**data)
    end

    def delete(webhook_id:, oauth_token:)
      partner_api.delete("webhooks/#{webhook_id}")
      true
    end

    private

    attr_reader :partner_api
  end
end
