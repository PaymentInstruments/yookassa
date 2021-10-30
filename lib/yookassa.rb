# frozen_string_literal: true

require "http"
require "dry-initializer"
require "yookassa/version"
require "yookassa/payment"
require "yookassa/refund"
require "yookassa/response"
require "yookassa/callable"
require "yookassa/optional"
require "yookassa/entity/payment"
require "yookassa/entity/refund"
require "yookassa/error"
require "yookassa/config"
require "yookassa/http_helpers"

module Yookassa
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end
end
