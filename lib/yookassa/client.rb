# frozen_string_literal: true

require "http"
require_relative "./payments"
require_relative "./refunds"
require_relative "./entity/error"

module Yookassa
  class Client
    API_URL = "https://api.yookassa.ru/v3/"

    attr_reader :http

    def initialize(shop_id:, api_key:)
      @http = HTTP.basic_auth(user: shop_id, pass: api_key).headers(accept: "application/json")
    end

    def payments
      @payments ||= Payments.new(self)
    end

    def refunds
      @refunds ||= Refunds.new(self)
    end

    def get(endpoint, query: {})
      api_call { http.get("#{API_URL}#{endpoint}", params: query) }
    end

    def post(endpoint, idempotency_key:, payload: {})
      api_call { http.headers("Idempotence-Key" => idempotency_key).post("#{API_URL}#{endpoint}", json: payload) }
    end

    private

    def api_call
      response = yield if block_given?
      body = JSON.parse(response.body.to_s, symbolize_names: true)
      return body if response.status.success?

      Entity::Error.new(**body)
    end
  end
end
