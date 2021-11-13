# frozen_string_literal: true

require "http"
require_relative "./entity/error"

module Yookassa
  class Client
    API_URL = "https://api.yookassa.ru/v3/"

    attr_reader :http

    def initialize(shop_id: Yookassa.config.shop_id, api_key: Yookassa.config.api_key, oauth_token: nil)
      @http = HTTP.headers(accept: "application/json")

      if shop_id && api_key
        @http.basic_auth(user: shop_id, pass: api_key)
      elsif oauth_token
        @http.headers("Authorization" => "Bearer #{oauth_token}")
      else
        message = "Specify `shop_id` and `api_key` settings in a `.configure` block " \
                  "or pass `oauth_token` to a client"
        raise ConfigError, message
      end
    end

    private

    def get(endpoint, query: {})
      api_call { http.get("#{API_URL}#{endpoint}", params: query) }
    end

    def post(endpoint, idempotency_key:, payload: {})
      api_call { http.headers("Idempotence-Key" => idempotency_key).post("#{API_URL}#{endpoint}", json: payload) }
    end

    def delete(endpoint, idempotency_key:)
      api_call { http.headers("Idempotence-Key" => idempotency_key).delete("#{API_URL}#{endpoint}") }
    end

    def api_call
      response = yield if block_given?
      body = JSON.parse(response.body.to_s, symbolize_names: true)
      return body if response.status.success?

      Entity::Error.new(**body)
    end
  end
end
