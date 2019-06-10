# frozen_string_literal: true

module YandexCheckout
  module Entity
    class Confirmation
      extend  Dry::Initializer
      extend  YandexCheckout::Callable
      include YandexCheckout::Optional

      option :type, proc(&:to_s), optional: true
      option :confirmation_url, proc(&:to_s), optional: true
      option :enforce, optional: true
      option :return_url, proc(&:to_s), optional: true
    end
  end
end
