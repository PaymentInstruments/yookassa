# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"
require_relative "./supplier"

module Yookassa
  module Entity
    class Product < Dry::Struct
      VatCodes = Types::Coercible::Integer.enum(
        1 => "VAT not included",
        2 => "0% VAT rate",
        3 => "10% VAT rate",
        4 => "20% receipt’s VAT rate",
        5 => "10/110 receipt’s estimate VAT rate",
        6 => "20/120 receipt’s estimate VAT rate"
      )

      AgentTypes = Types::String.enum(
        "banking_payment_agent",
        "banking_payment_subagent",
        "payment_agent",
        "payment_subagent",
        "attorney",
        "commissioner",
        "agent"
      )

      # Product name (maximum 128 characters).
      attribute :description, Types::String

      # Product quantity. Maximum possible value depends on the model of your online sales register.
      attribute :quantity, Types::Coercible::Float

      # Product price
      attribute :amount, Amount

      # VAT rate. Possible value is a number from 1 to 6. More about VAT rates codes
      # https://yookassa.ru/en/developers/54fz/parameters-values#vat-codes
      attribute :vat_code, VatCodes

      # Payment subject attribute. List of possible values: https://yookassa.ru/en/developers/54fz/parameters-values#payment-subject
      attribute? :payment_subject, Types::String

      # Payment method attribute. List of possible values: https://yookassa.ru/en/developers/54fz/parameters-values#payment-mode
      attribute? :payment_mode, Types::String

      # Product code is a unique number assigned to a unit of product during marking process.
      # Format: hexadecimal number with spaces. Maximum length is 32 bytes.
      # Example: 00 00 00 01 00 21 FA 41 00 23 05 41 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 00 AB 00.
      # Required parameter for marked products. http://docs.cntd.ru/document/557297080
      attribute? :product_code, Types::String

      # Country of origin code according to the Russian classifier of world countries (OK (MK (ISO 3166) 004-97) 025-2001).
      # Example: RU.
      # Online sales register tthat support this parameter: Orange Data, Kit Invest.
      attribute? :country_of_origin_code, Types::String

      # Customs declaration number (1 to 32 characters).
      # Online sales register that support this parameter: Orange Data, Kit Invest.
      attribute? :customs_declaration_number, Types::String

      # Amount of excise tax on products including kopeks. Decimal number with 2 digits after the period.
      # Online sales register that support this parameter: Orange Data, Kit Invest.
      attribute? :excise

      # Information about the supplier of product or service. You can specify this parameter if you send the data
      # for creating the receipt using the Receipt after payment scenario.
      attribute? :supplier, Supplier

      # Type of agent selling goods or services. The parameter is provided for by the format of fiscal documents (FFD)
      # and is considered mandatory for versions 1.1 and later. https://yookassa.ru/en/developers/54fz/parameters-values#agent-type
      # You can send it if your online sales register is updated to FFD 1.1
      # and if you send the data for creating the receipt using the Receipt after payment scenario
      attribute? :agent_type, AgentTypes
    end
  end
end
