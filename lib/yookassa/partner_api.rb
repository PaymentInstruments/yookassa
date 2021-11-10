# frozen_string_literal: true

require "http"

require_relative "./stores"
require_relative "./webhooks"
require_relative "./entity/error"

module Yookassa
  class PartnerAPI
    API_URL = "https://api.yookassa.ru/v3/"

    def initialize(oauth_token:)
      @http = HTTP.headers("Authorization" => "Bearer #{oauth_token}")
                  .headers(accept: "application/json")
    end

    def stores
      @stores ||= Stores.new(self)
    end

    def webhooks
      @webhooks ||= Webhooks.new(self)
    end

    def get(endpoint)
      api_call { get("#{API_URL}#{endpoint}", params: query) }
    end

    def post(endpoint, idempotency_key:, payload: {})
      api_call { http.headers("Idempotence-Key" => idempotency_key).post("#{API_URL}#{endpoint}", json: payload) }
    end

    def delete(endpoint, idempotency_key:)
      HTTP.headers("Authorization" => "Bearer #{oauth_token}")
          .headers("Idempotence-Key" => idempotency_key)
          .delete("#{API_URL}#{endpoint}")
      end
    end

    private

    attr_reader :oauth_token

    def api_call
      response = yield if block_given?
      body = JSON.parse(response.body.to_s, symbolize_names: true)
      return body if response.status.success?

      Entity::Error.new(**body)
    end
  end
end
