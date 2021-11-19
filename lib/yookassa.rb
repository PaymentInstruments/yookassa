# frozen_string_literal: true

require "dry-struct"
require "forwardable"
require "yookassa/version"
require "yookassa/config"
require "yookassa/payments"
require "yookassa/refunds"
require "yookassa/receipts"

module Yookassa
  class << self
    extend Forwardable

    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end

    def payments
      @payments ||= Payments.new
    end

    def refunds
      @refunds ||= Refunds.new
    end

    def receipts
      @receipts ||= Receipts.new
    end
  end
end
