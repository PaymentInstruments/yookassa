# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"

module Yookassa
  module Entity
    class Refund < Dry::Struct
      attribute :id, Types::String
      attribute? :idempotency_key, Types::String
      attribute :status, Types::String
      attribute :payment_id, Types::String
      attribute :created_at, Types::String
      attribute :amount, Entity::Amount
      attribute? :receipt_registration, Types::String
      attribute :description, Types::String
    end
  end
end
