# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Card < Dry::Struct
      attribute :first6, Types::Integer
      attribute :last4, Types::Integer
      attribute :expiry_month, Types::Integer
      attribute :expiry_year, Types::Integer
      attribute :card_type, Types::String
      attribute :source, Types::String
    end
  end
end
