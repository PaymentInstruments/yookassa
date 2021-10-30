# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Confirmation < Dry::Struct
      attribute :type, Types::String
      attribute :confirmation_url, Types::String
      attribute? :enforce, Types::Bool
      attribute? :return_url, Types::String
    end
  end
end
