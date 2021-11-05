# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class FlightLeg < Dry::Struct
      # IATA: https://www.iata.org/publications/Pages/code-search.aspx

      # Code of the departure airport according to IATA, for example, LED.
      attribute :departure_airport, Types::String

      # Code of the arrival airport according to IATA, for example, AMS.
      attribute :destination_airport, Types::String

      # Departure date in the YYYY-MM-DD ISO 8601:2004 format.
      attribute :departure_date, Types::JSON::DateTime

      # Airline code according to IATA.
      attribute :carrier_code, Types::String
    end
  end
end
