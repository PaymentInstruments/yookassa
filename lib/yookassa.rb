# frozen_string_literal: true

require 'evil/client'

require 'yookassa/version'
require 'yookassa/configuration'
require 'yookassa/payment'
require 'yookassa/refund'
require 'yookassa/response'
require 'yookassa/callable'
require 'yookassa/optional'
require 'yookassa/entity/payment'
require 'yookassa/entity/refund'
require 'yookassa/entity/notification'
require 'yookassa/error'

module Yookassa
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Configuration.new
  end
end
