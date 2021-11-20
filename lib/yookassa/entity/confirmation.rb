# frozen_string_literal: true

require_relative "./types"

module Yookassa
  module Entity
    class Confirmation
      class Base < Dry::Struct
        # Language of the interface, emails, and text messages that will be displayed or sent to the user.
        # Formatted in accordance with ISO/IEC 15897. Possible values: ru_RU, en_US, de_DE. Case sensitive.
        # https://en.wikipedia.org/wiki/Locale_(computer_software)
        attribute? :locale, Types::String
      end

      class Embedded < Base
        attribute :type, Types.Value("embedded")

        # Token for the YooMoney Checkout Widget initialization.
        attribute :confirmation_token, Types::String
      end

      class External < Base
        attribute :type, Types.Value("external")
      end

      class MobileApplication < Base
        attribute :type, Types.Value("mobile_application")

        # URL or deep link, to which user will return after confirming or canceling the payment in the app.
        # Send the URL if the payment was made via the mobile version of the website or send the deep link
        # if the payment was made via mobile app. Maximum 2048 characters.
        attribute :return_url, Types::String

        # Deep link to the mobile app where the user confirms the payment.
        attribute? :confirmation_url, Types::String
      end

      class QrCode < Base
        attribute :type, Types.Value("qr")

        # Data for generating the QR code.
        attribute :confirmation_data, Types::String
      end

      class Redirect < Base
        attribute :type, Types.Value("redirect")

        # The URL that the user will be redirected to for payment confirmation.
        attribute :confirmation_url, Types::String

        # A request for making a payment with authentication by 3-D Secure. It works if you accept
        # bank card payments without user confirmation by default. In other cases, the 3-D Secure
        # authentication will be handled by YooMoney. If you would like to accept payments without
        # additional confirmation by the user, contact your YooMoney manager.
        attribute? :enforce, Types::Bool

        # The URL that the user will return to after confirming or canceling the payment on the webpage.
        # Maximum 2048 characters.
        attribute? :return_url, Types::String
      end
    end

    Confirmations = Confirmation::Embedded |
                    Confirmation::External |
                    Confirmation::MobileApplication |
                    Confirmation::QrCode |
                    Confirmation::Redirect
  end
end
