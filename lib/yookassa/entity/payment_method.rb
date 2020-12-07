# frozen_string_literal: true

require_relative './card'

module Yookassa
  module Entity
    class PaymentMethod
      extend  Dry::Initializer
      extend  Yookassa::Callable
      include Yookassa::Optional

      option :type, proc(&:to_s)
      option :id, proc(&:to_s)
      option :saved
      option :card, Entity::Card, optional: true
      option :title, proc(&:to_s), optional: true
    end
  end
end
