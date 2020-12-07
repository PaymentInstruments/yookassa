# frozen_string_literal: true

module Yookassa
  class Payment < Evil::Client
    option :shop_id,  proc(&:to_s)
    option :api_key,  proc(&:to_s)

    path { 'https://api.yookassa.ru/v3/payments' }
    security { basic_auth shop_id, api_key }

    operation :get_payment_info do
      option :payment_id, proc(&:to_s)

      http_method :get
      path { "/#{payment_id}" }

      response(200) { |*res| Entity::Payment.build(*res) }
      response(400, 404) { |*res| Error.build(*res) }
    end

    operation :create do
      option :payment
      option :idempotency_key, proc(&:to_s)

      http_method :post

      format 'json'
      headers { { 'Idempotence-Key' => idempotency_key } }
      body { payment }

      response(200) { |*res| Entity::Payment.build(*res) }
      response(400) { |*res| Error.build(*res) }
    end

    operation :capture do
      option :payment_id, proc(&:to_s)
      option :idempotency_key, optional: true

      http_method :post

      path { "/#{payment_id}/capture" }

      format 'json'
      headers { { 'Idempotence-Key' => idempotency_key } }

      response(200) { |*res| Entity::Payment.build(*res) }
      response(400) { |*res| Error.build(*res) }
    end

    operation :cancel do
      option :payment_id, proc(&:to_s)
      option :idempotency_key, optional: true

      http_method :post

      path { "/#{payment_id}/cancel" }

      format 'json'
      headers { { 'Idempotence-Key' => idempotency_key } }

      response(200) { |*res| Entity::Payment.build(*res) }
      response(400) { |*res| Error.build(*res) }
    end
  end
end
