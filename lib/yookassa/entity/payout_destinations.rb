# frozen_string_literal: true

require_relative "./types"
require_relative "./card"

module Yookassa
  module Entity
    module PayoutDestination
      class BankCard < Base
        attribute :type, Types.Value("bank_card")

        attribute? :card, Card
      end

      class YooMoney < Base
        attribute :type, Types.Value("yoo_money")

        # account_number [string, optional]
        # The number of the YooMoney wallet used for making the payment.
        attribute? :account_number, Types::String.constrained(min_size: 11, max_size: 33)
      end
    end

    PayoutDestinations = PayoutDestination::BankCard | PayoutDestination::YooMoney
  end
end
