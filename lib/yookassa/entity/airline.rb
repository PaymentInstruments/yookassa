# frozen_string_literal: true

require_relative "./types"
require_relative "./passenger"
require_relative "./flight_leg"

module Yookassa
  module Entity
    class Airline < Dry::Struct
      # Unique ticket number. If you already know the ticket number during payment creation, ticket_number
      # is a required parameter. If you don't, specify booking_reference instead of ticket_number.
      attribute? :ticket_number, Types::String

      # Booking reference number, required if ticket_number is not specified.
      attribute? :booking_reference, Types::String

      # List of passengers.
      attribute? :passengers, Types::Array.of(Yookassa::Entity::Passenger)

      # List of flight legs.
      attribute? :legs, Types::Array.of(Yookassa::Entity::FlightLeg)
    end
  end
end
