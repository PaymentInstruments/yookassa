# frozen_string_literal: true

module Yookassa
  module Callable
    def call(*args)
      new(*args)
    end
    alias [] call
  end
end
