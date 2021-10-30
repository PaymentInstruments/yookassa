# frozen_string_literal: true

module Yookassa
  class Response
    extend Dry::Initializer
    option :id, proc(&:to_s)
    option :status, proc(&:to_s), default: proc {}
  end
end
