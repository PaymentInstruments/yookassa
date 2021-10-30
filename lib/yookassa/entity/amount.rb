# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Amount < Dry::Struct
      attribute :value, Types::Coercible::Float
      attribute :currency, Types::String
    end
  end
end
