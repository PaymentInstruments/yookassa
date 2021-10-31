# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Card < Dry::Struct
      # first6 [string, optional]
      # First 6 digits of the card’s number (BIN). For payments with bank cards saved in YooMoney
      # and other services, the specified BIN might not correspond with the last4, expiry_year, expiry_month values.
      # For payments with bank cards saved in Apple Pay or Google Pay, the parameter contains Device Account Number.
      attribute? :first6, Types::String

      # last4 [string, required]
      # Last 4 digits of the card's number.
      attribute :last4, Types::String

      # expiry_month [string, required]
      # Expiration date, month, MM.
      attribute :expiry_month, Types::Coercible::Integer

      # expiry_year [string, required]
      # Expiration date, year, YYYY.
      attribute :expiry_year, Types::Coercible::Integer

      # card_type [string, required]
      # Type of bank card. Possible values: MasterCard (for Mastercard and Maestro cards), Visa (for Visa and Visa Electron cards),
      # Mir, UnionPay, JCB, AmericanExpress, DinersClub, and Unknown.
      attribute :card_type, Types::String.enum("MasterCard", "Visa", "Mir", "UnionPay", "JCB", "AmericanExpress", "DinersClub", "Unknown")

      # issuer_country [string, optional]
      # Code of the country where the bank card was issued according to ISO-3166 alpha-2. Example: RU.
      attribute? :issuer_country, Types::String

      # issuer_name [string, optional]
      # Name of the issuing bank.
      attribute? :issuer_name, Types::String

      # source [string, optional]
      # Source of bank card details. Possible values: apple_pay, google_pay.
      # For payments where the user selects a card saved in Apple Pay or Google Pay.
      attribute? :source, Types::String.enum("apple_pay", "google_pay")
    end
  end
end
