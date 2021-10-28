# frozen_string_literal: true

require "evil/client"

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

module Yookassa
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end
end
