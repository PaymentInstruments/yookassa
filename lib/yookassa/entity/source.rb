# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"

module Yookassa
  module Entity
    class Source < Dry::Struct
      # account_id [string, required]
      # ID of the store in favor of which you're accepting the receipt. Provided by YooMoney, displayed in the Sellers section
      # of your Merchant Profile (shopId column).
      attribute :account_id, Types::String

      # amount [object, required]
      # Refund amount
      attribute :amount, Entity::Amount

      # platform_fee_amount [object, optional]
      # Commission for sold products or services charged in your favor.
      attribute? :platform_fee_amount, Entity::Amount
    end
  end
end
