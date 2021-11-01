# frozen_string_literal: true

require_relative "./types"
require_relative "./amount"
require_relative "./payment_methods"
require_relative "./confirmation"
require_relative "./recipient"
require_relative "./cancellation_details"
require_relative "./authorization_details"
require_relative "./transfer"

module Yookassa
  module Entity
    class Payment < Dry::Struct
      # id [string, required]
      # Payment ID in YooMoney.
      attribute :id, Types::String

      attribute? :idempotency_key, Types::String

      # status [string, required]
      # Payment status. Possible values: pending, waiting_for_capture, succeeded, and canceled.
      # More about the life cycle of a payment https://yookassa.ru/en/developers/api#:~:text=life%20cycle%20of%20a%20payment%C2%A0
      attribute :status, Types::String.enum("pending", "waiting_for_capture", "succeeded", "canceled")

      # amount [object, required]
      # Payment amount. Sometimes YooMoney's partners charge additional commission from the users that is not included in this amount.
      attribute :amount, Entity::Amount

      # income_amount [object, optional]
      # Amount of payment to be received by the store: the amount value minus the YooMoney commission.
      # If you're a partner  using an OAuth token for request authentication, make a request to the store for a right
      # to get information about commissions on payments.
      attribute? :income_amount, Entity::Amount

      # description [string, optional]
      # Description of the transaction (maximum 128 characters) displayed in your YooMoney Merchant Profile,
      # and shown to the user during checkout. For example, "Payment for order No. 72 for user@yoomoney.ru".
      attribute? :description, Types::String.constrained(max_size: 128)

      # recipient [object, required]
      # Payment recipient.
      attribute :recipient, Entity::Recipient

      # payment_method [object, optional]
      # Payment method  used for this payment.
      attribute? :payment_method, Entity::PaymentMethods

      # captured_at [datetime, optional]
      # Time of payment capture, based on UTC and specified in the ISO 8601 format. "2018-07-18T10:51:18.139Z"
      attribute? :captured_at, Types::JSON::DateTime

      # created_at [datetime, required]
      # Time of order creation, based on UTC and specified in the ISO 8601 format. Example: 2017-11-03T11:52:31.827Z
      attribute :created_at, Types::JSON::DateTime

      # expires_at [string, optional]
      # The period during which you can cancel or capture a payment for free. The payment with the waiting_for_capture status
      # will be automatically canceled at the specified time. Based on UTC and specified in the ISO 8601 format.
      attribute? :expires_at, Types::JSON::DateTime

      # confirmation [object, optional]
      # Selected payment confirmation scenario. For payments requiring confirmation from the user.
      # More about confirmation scenarios https://yookassa.ru/en/developers/api#:~:text=confirmation,from%20the%20user.%20More%20about%20confirmation%20scenarios%C2%A0
      attribute? :confirmation, Entity::Confirmation

      # test [boolean, required]
      # The attribute of a test transaction.
      attribute :test, Types::Bool

      # refunded_amount [object, optional]
      # The amount refunded to the user. Specified if the payment has successful refunds.
      attribute? :refunded_amount, Entity::Amount

      # paid [boolean, required]
      # The attribute of a paid order.
      attribute :paid, Types::Bool

      # refundable [boolean, required]
      # Availability of the option to make a refund via API.
      attribute :refundable, Types::Bool

      # receipt_registration [string, optional]
      # Delivery status of receipt data to online sales register (pending, succeeded, or canceled). For those who use the solution for 54-FZ .
      attribute? :receipt_registration, Types::String.enum("pending", "succeeded", "canceled")

      # metadata [object, optional]
      # Any additional data you might require for processing payments (for example, order number), specified as a “key-value” pair
      # and returned in response from YooMoney.
      # Limitations:
      # - no more than 16 keys,
      # - no more than 32 characters in the key’s title,
      # - no more than 512 characters in the key’s value,
      # - data type is a string in the UTF-8 format.
      attribute? :metadata, Types::Hash

      # cancellation_details [object, optional]
      # Commentary to the canceled status: who and why canceled the payment.
      # More about canceled payments https://yookassa.ru/en/developers/api#:~:text=cancellation_details,about%20canceled%20payments%C2%A0
      attribute? :cancellation_details, Entity::CancellationDetails

      # authorization_details [object, optional]
      # Payment authorization details.
      attribute? :authorization_details, Entity::AuthorizationDetails

      # transfers [array, optional]
      # Information about money distribution: the amounts of transfers and the stores to be transferred to.
      # Specified if you use the YooMoney solution for marketplaces https://yookassa.ru/en/developers/special-solutions/checkout-for-platforms/basics
      attribute? :transfers, Types::Array.of(Entity::Transfer)

      # merchant_customer_id [string, optional]
      # The identifier of the customer in your system, such as email address or phone number. No more than 200 characters.
      # Specified if you want to save a bank card and offer it for a recurring payment
      # in the YooMoney payment widget https://yookassa.ru/en/developers/payment-forms/widget/basics.
      attribute? :merchant_customer_id, Types::String
    end
  end
end
