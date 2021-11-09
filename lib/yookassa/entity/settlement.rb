# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"

module Yookassa
  module Entity
    class Settlement < Dry::Struct
      # Type of settlement. List of possible values
      attribute :type, Types::String.enum("cashless", "prepayment", "postpayment", "consideration")

      # Settlement amount.
      attribute :amount, Amount
    end
  end
end
