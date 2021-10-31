# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class CancellationDetails < Dry::Struct
      # party [string, required]
      # The participant of the payment process that made the decision to cancel the payment.
      # Possible values are yoo_money, payment_network, and merchant. More about initiators of payment cancelation
      attribute :party, Types::String.enum("yoo_money", "payment_network", "merchant")

      # reason [string, required]
      # Reason behind the cancelation. Possible values https://yookassa.ru/en/developers/payments/declined-payments#cancellation-details-reason
      attribute :reason, Types::String
    end
  end
end
