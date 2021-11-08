# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"
require_relative "./source"

module Yookassa
  module Entity
    class Refund < Dry::Struct
      attribute? :idempotency_key, Types::String
      # id [string, required]
      # Refund's ID in YooMoney
      attribute :id, Types::String

      # payment_id [string, required]
      # Payment ID in YooMoney
      attribute :payment_id, Types::String

      # status [string, required]
      # Refund status. Possible values: canceled, succeeded
      attribute :status, Types::String.enum("canceled", "succeeded")

      # receipt_registration [string, optional]
      # Delivery status of receipt data to online sales register (pending, succeeded, or canceled).
      # For those who use the solution for 54-FZ
      attribute? :receipt_registration, Types::String.enum("pending", "succeeded", "canceled")

      # created_at [string, required]
      # Time to refund creation, based on UTC and specified in the ISO 8601 format, for example, 2017-11-03T11:52:31.827Z
      attribute :created_at, Types::String

      # amount [object, required]
      # Amount refunded to the user.
      attribute :amount, Entity::Amount

      # description [string, optional]
      # Reason behind the refund.
      attribute? :description, Types::String

      # sources [array, optional]
      # Information about money held for refunds: the amount to be held and the stores getting the refunds.
      # Specified if you use the YooMoney solution for marketplaces
      attribute? :sources, Types::Array.of(Entity::Source)
    end
  end
end
