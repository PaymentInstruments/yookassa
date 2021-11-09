# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Supplier < Dry::Struct
      # Supplier name. The parameter is provided for by the format of fiscal documents (FFD)
      # and is considered mandatory for versions 1.1 and later.
      attribute? :name, Types::String

      # Supplier's phone number. Specified in the ITU-T E.164 format, for example, 79000000000
      # The parameter is provided for by the format of fiscal documents (FFD) and is considered mandatory
      # for versions 1.1 and later.
      attribute? :phone, Types::String

      # Provider's masked INN/TIN.
      # The parameter is provided for by the format of fiscal documents (FFD) and is considered mandatory
      # for versions 1.05 and later.
      attribute? :inn, Types::String
    end
  end
end
