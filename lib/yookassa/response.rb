# frozen_string_literal: true

module Yookassa
  class Response
    extend Dry::Initializer
    option :id, proc(&:to_s)
    option :status, proc(&:to_s), default: proc { nil }

    class << self
      def build(*res)
        body = res.last
        new JSON.parse(body.first)
      end

      def new(opts)
        super opts.each_with_object({}) { |(key, val), obj| obj[key.to_sym] = val }
      end
    end
  end
end
