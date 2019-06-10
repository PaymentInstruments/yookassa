# frozen_string_literal: true

module YandexCheckout
  module Entity
    class Amount
      extend  Dry::Initializer
      extend  YandexCheckout::Callable
      include YandexCheckout::Optional

      option :value, proc(&:to_f), optional: true
      option :currency, proc(&:to_s), optional: true
    end
  end
end
