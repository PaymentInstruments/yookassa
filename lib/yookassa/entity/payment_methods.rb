# frozen_string_literal: true

require_relative "./types"
require_relative "./card"

module Yookassa
  module Entity
    module PaymentMethod
      class Base < Dry::Struct
        # id [string, required]
        # Payment method ID.
        attribute :id, Types::String

        # saved [boolean, required]
        # Saving payment methods allows conducting automatic recurring payments .
        attribute :saved, Types::Bool

        # title [string, optional]
        # Payment method name.
        attribute? :title, Types::String
      end

      class BankCard < Base
        attribute :type, Types.Value("bank_card")

        # login [string, optional]
        # User's login in Alfa-Click (linked phone number or the additional login).
        attribute? :card, Entity::Card
      end

      class Alfabank < Base
        attribute :type, Types.Value("alfabank")

        # login [string, optional]
        # User's login in Alfa-Click (linked phone number or the additional login).
        attribute? :login, Types::String
      end

      class YooMoney < Base
        attribute :type, Types.Value("yoo_money")

        # account_number [string, optional]
        # The number of the YooMoney wallet used for making the payment.
        attribute? :account_number, Types::String
      end

      class Sberbank < Base
        attribute :type, Types.Value("sberbank")

        # phone [string, optional]
        # TThe phone number specified during the registration process of the SberBank Online/SberPay account,
        # specified in the ITU-T E.164 format, for example, 79000000000.
        attribute? :phone, Types::String
      end

      class ApplePay < Base
        attribute :type, Types.Value("apple_pay")
      end

      class Cash < Base
        attribute :type, Types.Value("cash")
      end

      class DirectCarrierBilling < Base
        attribute :type, Types.Value("mobile_balance")
      end

      class GooglePay < Base
        attribute :type, Types.Value("google_pay")
      end

      class Installments < Base
        attribute :type, Types.Value("installments")
      end

      class Qiwi < Base
        attribute :type, Types.Value("qiwi")
      end

      class Tinkoff < Base
        attribute :type, Types.Value("tinkoff_bank")
      end

      class Wechat < Base
        attribute :type, Types.Value("wechat")
      end

      class Webmoney < Base
        attribute :type, Types.Value("webmoney")
      end
    end

    PaymentMethods =  PaymentMethod::BankCard |
                      PaymentMethod::Alfabank |
                      PaymentMethod::YooMoney |
                      PaymentMethod::Sberbank |
                      PaymentMethod::ApplePay |
                      PaymentMethod::Cash |
                      PaymentMethod::DirectCarrierBilling |
                      PaymentMethod::GooglePay |
                      PaymentMethod::Installments |
                      PaymentMethod::Qiwi |
                      PaymentMethod::Tinkoff |
                      PaymentMethod::Wechat |
                      PaymentMethod::Webmoney
  end
end
