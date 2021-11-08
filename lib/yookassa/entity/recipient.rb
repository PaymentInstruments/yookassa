# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Recipient < Dry::Struct
      attribute :account_id, Types::Coercible::Integer
      attribute :gateway_id, Types::Coercible::Integer
    end
  end
end
