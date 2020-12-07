# frozen_string_literal: true

require_relative './amount'
require_relative './payment_method'
require_relative './confirmation'

module Yookassa
  module Entity
    class Payment < Yookassa::Response
      option :paid
      option :amount, Entity::Amount
      option :created_at
      option :captured_at, proc(&:to_s), optional: true
      option :expires_at, optional: true
      option :description, proc(&:to_s), optional: true
      option :metadata, optional: true
      option :payment_method, Entity::PaymentMethod, optional: true
      option :confirmation, Entity::Confirmation, optional: true
      option :test
    end
  end
end
