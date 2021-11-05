# frozen_string_literal: true

require "dry-struct"
require "forwardable"
require "yookassa/version"
require "yookassa/config"
require "yookassa/client"

module Yookassa
  ConfigError = Class.new(StandardError)

  class << self
    extend Forwardable

    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end

    def client
      raise ConfigError, "Specify `shop_id` and `api_key` or `auth_token` settings in a `.configure` block" if @config.nil?

      @client ||= Client.new(shop_id: @config.shop_id, api_key: @config.api_key, auth_token: @config.auth_token)
    end

    def_delegators :client, :payments, :refunds, :webhooks
  end
end
