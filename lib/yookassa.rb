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
      raise ConfigError, "Specify `shop_id` and `api_key` settings in a `.configure` block" if @config.nil?

      @client ||= Client.new(shop_id: @config.shop_id, api_key: @config.api_key)
    end

    def partner_api
      @partner_api ||= PartnerAPI.new
    end

    def_delegators :client, :payments, :refunds, :receipts

    def_delegators :partner_api, :stores, :webhooks
  end
end
