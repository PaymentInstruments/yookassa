# frozen_string_literal: true

require_relative "http_helpers"

module Yookassa
  class Refund
    include HttpHelpers

    attr_reader :shop_id, :api_key

    def initialize(shop_id: Yookassa.config.shop_id, api_key: Yookassa.config.api_key)
      @shop_id = shop_id
      @api_key = api_key
    end

    def get_refund_info(payment_id:)
      get("refunds/#{payment_id}") do |response|
        Entity::Refund.new(response)
      end
    end

    def create(payload:, idempotency_key: SecureRandom.hex(10))
      post("refunds", payload: payload, idempotency_key: idempotency_key) do |response|
        Entity::Refund.new(response)
      end
    end
  end
end
