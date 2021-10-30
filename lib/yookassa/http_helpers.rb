# frozen_string_literal: true

module Yookassa
  module HttpHelpers
    API_URL = "https://api.yookassa.ru/v3/"

    def get(endpoint, query: {})
      response = client.get("#{API_URL}#{endpoint}", params: query)
      body = JSON.parse(response.body.to_s, symbolize_names: true)

      return Error.new(body) if response.status.client_error?

      yield(body) if block_given?
    end

    def post(endpoint, idempotency_key:, payload: {})
      response = client.headers("Idempotence-Key" => idempotency_key).post("#{API_URL}#{endpoint}", json: payload)
      body = JSON.parse(response.body.to_s, symbolize_names: true)

      return Error.new(body) if response.status.client_error?

      yield(body) if block_given?
    end

    def client
      HTTP.basic_auth(user: shop_id, pass: api_key).headers(accept: "application/json")
    end
  end
end
