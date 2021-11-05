# frozen_string_literal: true

require_relative "./entity/refund"

module Yookassa
  class Webhooks
    def initialize(api)
      @api = api
    end

    def add(webhook_)
      data = api.post("webhooks", payload: payload, idempotency_key: idempotency_key)
      Entity::Webhook.new(**data.merge(idempotency_key: idempotency_key))
    end

    def remove(webhook_id:)
      data = api.delete("webhooks/#{webhook_id}")
      # return Succeess if data.nil?
    end

    def list

    end


    private

    attr_reader :api
  end
end
