# frozen_string_literal: true

require_relative "./types"
require_relative "./card"

module Yookassa
  module Entity
    class PaymentMethod < Dry::Struct
      attribute :type, Types::String
      attribute :id, Types::String
      attribute :saved, Types::Bool
      attribute? :card, Entity::Card
      attribute? :title, Types::String
    end
  end
end
