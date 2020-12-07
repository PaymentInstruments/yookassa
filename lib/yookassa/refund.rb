# frozen_string_literal: true

module Yookassa
  class Refund < Evil::Client
    option :shop_id,  proc(&:to_s)
    option :api_key,  proc(&:to_s)

    path { 'https://api.yookassa.ru/v3/refunds' }
    security { basic_auth shop_id, api_key }

    operation :get_refund_info do
      option :payment_id, proc(&:to_s)

      http_method :get
      path { "/#{payment_id}" }

      response(200) { |*res| Entity::Refund.build(*res) }
      response(400, 404) { |*res| Error.build(*res) }
    end

    operation :create do
      option :payload
      option :idempotency_key, proc(&:to_s)

      http_method :post

      format 'json'
      headers { { 'Idempotence-Key' => idempotency_key } }
      body { payload }

      response(200) { |*res| Entity::Refund.build(*res) }
      response(400, 404) { |*res| Error.build(*res) }
    end
  end
end
