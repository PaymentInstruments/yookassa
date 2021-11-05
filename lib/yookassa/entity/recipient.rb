# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Recipient < Dry::Struct
      attribute? :account_id, Types::Coercible::String
      attribute :gateway_id, Types::Coercible::String
    end
  end
end
