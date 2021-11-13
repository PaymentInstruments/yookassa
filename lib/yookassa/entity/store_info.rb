# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class StoreInfo < Dry::Struct
      # Store's ID in YooMoney.
      attribute :account_id, Types::Coercible::String

      # This is the Demo store
      attribute :test, Types::Bool

      # Sending receipts to online sales register enabled in store's settings.
      attribute :fiscalization_enabled, Types::Bool

      # List of payment methods available to a store.
      attribute :payment_methods, Types::Array.of(Types::String)

      # Store's status. Possible values: enabled
      # – store is signed up for YooMoney and it can accept payments; disabled
      # – store can't accept payments (not signed up yet, closed, or temporarily unavailable).
      attribute :status, Types::String.enum("enabled", "disabled")

      # Store's INN (TIN): 10 or 12 digits.
      attribute? :itn, Types::Coercible::String.constrained(max_size: 12, min_size: 10)
    end
  end
end
