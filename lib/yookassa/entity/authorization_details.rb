# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class AuthorizationDetails < Dry::Struct
      # rrn [string, optional]
      # Retrieval Reference Number is a unique identifier of a transaction in the issuer's system. Used for payments via bank card.
      attribute? :rrn, Types::String

      # auth_code [string, optional]
      # Bank card's authorization code. Provided by the issuer to confirm authorization.
      attribute? :auth_code, Types::String

      # three_d_secure [object, optional]
      # Information about user’s 3‑D Secure authentication for confirming the payment.
      attribute? :three_d_secure, Types::Hash.schema(

        # applied [boolean, required]
        # Information on whether the 3-D Secure authentication form is displayed to the user for confirming the payment or not.
        # true: YooMoney displayed the form to the user, so that they could complete 3-D Secure authentication;
        # false: payment was processed without 3-D Secure authentication.
        applied: Types::Bool
      ).with_key_transform(&:to_sym)
    end
  end
end
