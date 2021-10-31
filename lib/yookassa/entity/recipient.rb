# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Recipient < Dry::Struct
      attribute :account_id, Types::String
      attribute :gateway_id, Types::String
    end
  end
end
