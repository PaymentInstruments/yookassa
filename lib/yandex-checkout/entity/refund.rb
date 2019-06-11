# frozen_string_literal: true

require_relative './amount'

module YandexCheckout
  module Entity
    class Refund < YandexCheckout::Response
      option :payment_id
      option :created_at, proc(&:to_s)
      option :amount, Entity::Amount
      option :receipt_registration, proc(&:to_s), optional: true
      option :description, proc(&:to_s), optional: true
    end
  end
end
