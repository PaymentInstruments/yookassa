# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"
require_relative "./payment_method"
require_relative "./confirmation"

module Yookassa
  module Entity
    class Payment < Dry::Struct
      attribute :id, Types::String
      attribute :status, Types::String.enum("pending", "waiting_for_capture", "succeeded", "canceled")
      attribute :paid, Types::Bool
      attribute :amount, Entity::Amount
      attribute? :income_amount, Entity::Amount
      attribute :created_at, Types::String
      attribute? :captured_at, Types::String
      attribute? :expires_at, Types::String
      attribute? :description, Types::String
      attribute :metadata, Types::Hash
      attribute :payment_method, Entity::PaymentMethod
      attribute :confirmation, Entity::Confirmation
      attribute :test, Types::Bool
    end
  end
end
