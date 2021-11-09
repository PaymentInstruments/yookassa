# frozen_string_literal: true

require_relative "./types"
require_relative "./customer"
require_relative "./product"
require_relative "./settlement"

module Yookassa
  module Entity
    class Receipt < Dry::Struct
      TaxSystemCodes = Types::Coercible::Integer.enum(
        1 => "General tax system",
        2 => "Simplified (STS, income)",
        3 => "Simplified (STS, income with costs deducted)",
        4 => "Unified tax on imputed income (ENVD)",
        5 => "Unified agricultural tax (ESN)",
        6 => "Patent Based Tax System"
      )

      # Receipt's ID in YooMoney.
      attribute :id, Types::String

      # Type of receipt in the online sales register: payment (payment) or payment refund (refund).
      attribute :type, Types::String.enum("payment", "refund")

      # ID of the payment that the receipt was created for.
      attribute? :payment_id, Types::String

      # ID of the refund that the receipt was created for. Not included in the payment receipt.
      attribute? :refund_id, Types::String

      # Delivery status of receipt data to online sales register (pending, succeeded, or canceled).
      attribute :status, Types::String.enum("pending", "succeeded", "canceled")

      # Fiscal document number.
      attribute? :fiscal_document_number, Types::String

      # Number of fiscal storage drive in online sales register.
      attribute? :fiscal_storage_number, Types::String

      # Fiscal attribute of the receipt. Created by the fiscal storage drive from the data sent for receipt registration.
      attribute? :fiscal_attribute, Types::String

      # Date and time of receipt creation in the fiscal storage drive, specified in the ISO 8601 format.
      attribute? :registered_at, Types::JSON::DateTime

      # Receipt's ID in online sales register. For successful receipt registration.
      attribute? :fiscal_provider_id, Types::String

      # Store's taxation system.
      attribute? :tax_system_code, TaxSystemCodes

      # List of products in the receipt (maximum 100 items).
      attribute :items, Types::Array.of(Product)

      # List of completed settlements.
      attribute? :settlements, Types::Array.of(Settlement)

      # ID of the store on behalf of which you're sending the receipt. Provided by YooMoney.
      # The parameter is required if you use the YooMoney solution for marketplaces.
      attribute? :on_behalf_of, Types::String
    end
  end
end
