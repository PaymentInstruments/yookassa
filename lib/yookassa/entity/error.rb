# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Error < Dry::Struct
      attribute :type, Types::String
      attribute? :id, Types::String
      attribute? :code, Types::String
      attribute? :description, Types::String
      attribute? :parameter, Types::String

      def error?
        type == "error"
      end
    end
  end
end
