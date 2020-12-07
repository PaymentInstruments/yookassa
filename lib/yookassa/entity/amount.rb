# frozen_string_literal: true

module Yookassa
  module Entity
    class Amount
      extend  Dry::Initializer
      extend  Yookassa::Callable
      include Yookassa::Optional

      option :value, proc(&:to_f), optional: true
      option :currency, proc(&:to_s), optional: true
    end
  end
end
