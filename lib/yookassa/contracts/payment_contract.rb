# frozen_string_literal: true

require_relative "../entity/types"
require_relative '../entity/airline'
require_relative '../entity/amount'
require_relative '../entity/confirmation'
require_relative '../entity/payment_methods'
require_relative '../entity/recipient'
require_relative '../entity/transfer'

module Yookassa
  module Contracts
    class PaymentContract < Dry::Validation::Contract
      params do
        # Payment amount. Sometimes YooMoney's partners charge additional commission from the users
        # that is not included in this amount.
        required(:amount).value(Yookassa::Entity::Amount)

        # Description of the transaction (maximum 128 characters) displayed in your YooMoney Merchant Profile,
        # and shown to the user during checkout. For example, "Payment for order No. 72 for user@yoomoney.ru".
        optional(:description).value(Types::String, max_size: 150)

        # Data for creating a receipt in the online sales register (for compliance with 54-FZ ).
        # Specify this parameter if you send the data for creating the receipt using one of these
        # scenarios:
        #   Payment and receipt at the same time (https://yookassa.ru/en/developers/54fz/basics#payment-and-receipt)
        #   or Payment after receipt (https://yookassa.ru/en/developers/54fz/basics#payment-after-receipt)
        optional(:receipt).value(Yookassa::Entity::Receipt)

        # Payment recipient. Required for separating payment flows within one account or making payments to other accounts.
        optional(:recipient).value(Yookassa::Entity::Recipient)

        # One-time payment token generated with the web or mobile SDK:
        # https://yookassa.ru/en/developers/payments/sdk-tokens
        optional(:payment_token).value(Types::String)

        # Saved payment method's ID: https://yookassa.ru/en/developers/payments/recurring-payments
        optional(:payment_method_id).value(Types::String)

        # Data for making payments using a certain method  (payment_method). You can send the request without this object.
        # If you do so, the user will be able to select the payment method on the YooMoney's side.
        optional(:payment_method_data).value(Yookassa::Entity::PaymentMethods)

        # Information required to initiate the selected payment confirmation scenario by the user.
        # More about confirmation scenarios: https://yookassa.ru/en/developers/payments/payment-process#user-confirmation
        optional(:confirmation).value(Yookassa::Entity::Confirmations)

        # Saving payment data (can be used for direct debits https://yookassa.ru/en/developers/payments/recurring-payments).
        # The true value initiates the creation of a reusable payment_method.
        optional(:save_payment_method).value(Types::Bool)

        # Automatic acceptance of an incoming payment. https://yookassa.ru/en/developers/payments/payment-process#capture-true
        optional(:capture).value(Types::Bool)

        # User’s IPv4 or IPv6 address. If not specified, the TCP connection’s IP address is used.
        optional(:client_ip).value(Types::String)

        # Any additional data you might require for processing payments (for example, order number), specified as a “key-value”
        # pair and returned in response from YooMoney.
        #
        # Limitations: no more than 16 keys, no more than 32 characters in the key’s title,
        # no more than 512 characters in the key’s value, data type is a string in the UTF-8 format.
        optional(:metadata).value(Types::String)

        # Object containing the data for selling airline tickets, used only for bank card payments.
        # https://yookassa.ru/en/developers/special-solutions/airline-tickets
        optional(:airline).value(Yookassa::Entity::Airline)

        # Information about money distribution: the amounts of transfers and the stores to be transferred to.
        # Specified if you use the YooMoney solution for marketplaces:
        # https://yookassa.ru/en/developers/special-solutions/checkout-for-platforms/basics
        optional(:transfers).value(Yookassa::Entity::Transfer)

        # The identifier of the customer in your system, such as email address or phone number.
        # No more than 200 characters. Specified if you want to save a bank card and offer it
        # for a recurring payment in the YooMoney payment widget.
        optional(:merchant_customer_id).value(Types::String, max_size: 200)
      end
    end
  end
end
