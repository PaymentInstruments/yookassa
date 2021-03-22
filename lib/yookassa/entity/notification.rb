# frozen_string_literal: true

require_relative './payment'

module Yookassa
  module Entity
    class Notification
      extend  Dry::Initializer
      extend  Yookassa::Callable
      include Yookassa::Optional

      option :type
      option :event
      option :object, Entity::Payment
      option :refundable, optional: true
      option :test, optional: true
    end
  end
end
