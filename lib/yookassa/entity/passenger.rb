# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Passenger < Dry::Struct
      # Passenger's first name. Only use Latin characters, for example, SERGEI.
      attribute :first_name, Types::String

      # Passenger's last name. Only use Latin characters, for example, IVANOV.
      attribute :last_name, Types::String
    end
  end
end
