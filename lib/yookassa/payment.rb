# frozen_string_literal: true

require_relative "http_helpers"

module Yookassa
  class Payment
    include HttpHelpers

    attr_reader :shop_id, :api_key

    def initialize(shop_id: Yookassa.config.shop_id, api_key: Yookassa.config.api_key)
      @shop_id = shop_id
      @api_key = api_key
    end

    def get_payment_info(payment_id:)
      get("payments/#{payment_id}") do |response|
        Entity::Payment.new(**response)
      end
    end

    def create(payment:, idempotency_key: SecureRandom.hex(10))
      post("payments", payload: payment, idempotency_key: idempotency_key) do |response|
        Entity::Payment.new(**response)
      end
    end

    def capture(payment_id:, idempotency_key: SecureRandom.hex(10))
      post("payments/#{payment_id}/capture", idempotency_key: idempotency_key) do |response|
        Entity::Payment.new(**response)
      end
    end

    def cancel(payment_id:, idempotency_key: SecureRandom.hex(10))
      post("payments/#{payment_id}/cancel", idempotency_key: idempotency_key) do |response|
        Entity::Payment.new(**response)
      end
    end

    # def self.list(shop_id: Yookassa.config.shop_id, api_key: Yookassa.config.api_key)
    #   get("payments", shop_id: shop_id, api_key: api_key) do |resp|
    #     resp['items'].map { Entity::Payment.new(_1) }
    #   end
    # end
  end
end
