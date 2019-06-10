# frozen_string_literal: true

require_relative './amount'
require_relative './payment_method'

module YandexCheckout
  module Entity
    class Payment < YandexCheckout::Response
      option :paid
      option :amount, Entity::Amount
      option :created_at
      option :expires_at, optional: true
      option :description, proc(&:to_s), optional: true
      option :metadata
      option :payment_method, Entity::PaymentMethod
      option :test
    end
  end
end
