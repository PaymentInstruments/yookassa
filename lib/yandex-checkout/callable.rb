# frozen_string_literal: true

module YandexCheckout
  module Callable
    def call(*args)
      new(*args)
    end
    alias [] call
  end
end
