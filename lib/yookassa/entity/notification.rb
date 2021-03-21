# frozen_string_literal: true

require_relative './payment'

module Yookassa
  module Entity
    class Notification < Yookassa::Response
      option :type
      option :event
      option :object, Entity::Payment
      option :refundable
      option :test
    end
  end
end
