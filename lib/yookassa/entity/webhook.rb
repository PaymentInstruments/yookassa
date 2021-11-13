# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Webhook < Dry::Struct
      attribute? :idempotency_key, Types::String

      # webhooks's ID in YooMoney
      attribute :id, Types::String

      # Event that YooMoney sends notifications for.
      attribute :event, Types::String.enum(
        "payment.waiting_for_capture", # payment status changed to waiting_for_capture
        "payment.succeeded",           # payment status changed to succeeded
        "payment.canceled",            # payment status changed to canceled
        "refund.succeeded"             # refund status changed to succeeded
      )

      # URL for sending YooMoney's notifications.
      attribute :url, Types::String
    end
  end
end
