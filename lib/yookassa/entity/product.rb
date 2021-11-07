# frozen_string_literal: true

require_relative "./amount"

module Yookassa
  module Entity
    class Product < Dry::Struct
      # Product name (maximum 128 characters).
      attribute :description, Types::String

      # Product quantity. Maximum possible value depends on the model of your online sales register.
      attribute :quantity, Types::String

      # Product price
      attribute :amount, Yookassa::Entity::Amount

      # VAT rate. Possible value is a number from 1 to 6. More about VAT rates codes
      # https://yookassa.ru/en/developers/54fz/parameters-values#vat-codes
      attribute :vat_code, Types::Integer

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
    end
  end
end
