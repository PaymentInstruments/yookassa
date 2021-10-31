# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"

module Yookassa
  module Entity
    class Transfer < Dry::Struct
      # account_id [string, required]
      # ID of the store in favor of which you're accepting the receipt. Provided by YooMoney, displayed in the Sellers section
      # of your Merchant Profile (shopId column).
      attribute :account_id, Types::String

      # amount [object, required]
      # Amount to be transferred to the store.
      attribute :amount, Entity::Amount

      # status [string, required]
      # Status of the money distribution between stores. Possible values: pending, waiting_for_capture, succeeded, canceled.
      attribute :status, Types::String.enum("pending", "waiting_for_capture", "succeeded", "canceled")

      # platform_fee_amount [object, optional]
      # Commission for sold products or services charged in your favor.
      attribute? :platform_fee_amount, Entity::Amount

      # metadata [object, optional]
      # Any additional data you might require for processing payments (for example, order number), specified as a “key-value” pair
      # and returned in response from YooMoney. Limitations: no more than 16 keys, no more than 32 characters in the key’s title,
      # no more than 512 characters in the key’s value, data type is a string in the UTF-8 format.
      attribute? :metadata, Types::Hash
    end
  end
end
