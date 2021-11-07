# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Customer < Dry::Struct
      # Name of the organization for companies, full name for sole proprietors and individuals.
      # If the individual doesn't have a Tax Identification Number (INN),
      # specify their passport information in this parameter. Maximum 256 characters.
      # Online sales register that support this parameter: Orange Data, ATOL Online.
      attribute? :full_name, Types::String

      # User's Tax Identification Number (INN) (10 or 12 digits). If the individual doesn't have an INN,
      # specify their passport information in the full_name parameter.
      # Online sales register that support this parameter: Orange Data, ATOL Online.
      attribute? :inn, Types::String

      # User's email address for sending the receipt.
      # Required parameter if phone isn't specified.
      attribute? :email, Types::String

      # User's phone number for sending the receipt. Specified in the ITU-T E.164 format, for example, 79000000000.
      # Required parameter if email isn't specified.
      attribute? :phone, Types::String
    end
  end
end
