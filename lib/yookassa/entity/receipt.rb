# frozen_string_literal: true

require_relative "./types"
require_relative "./customer"
require_relative "./product"

module Yookassa
  module Entity
    class Receipt < Dry::Struct
      # User details. You should specify at least the basic contact information:
      # email address (customer.email) or phone number (customer.phone)
      attribute? :customer, Yookassa::Entity::Customer

      # List of products in an order (maximum 100 items).
      attribute :items, Types::Array.of(Yookassa::Entity::Product)

      # Store's tax system. The parameter is only required if you use several tax systems.
      # Otherwise, the parameter is not specified. List of possible values:
      # https://yookassa.ru/en/developers/54fz/parameters-values#tax-systems
      attribute? :tax_system_code, Types::Coercible::Integer

      # User's phone number for sending the receipt. Set in the ITU-T E.164 format, for example, 79000000000.
      # !DEPRECATED PARAMETER: we recommend specifying the details in the receipt.customer.phone parameter.
      attribute? :phone, Types::Coercible::String

      # User's email address for sending the receipt.
      # !DEPRECATED PARAMETER: we recommend specifying the details in the receipt.customer.email parameter.
      attribute? :email, Types::String
    end
  end
end
