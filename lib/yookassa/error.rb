# frozen_string_literal: true

module Yookassa
  class Error
    extend  Dry::Initializer
    extend  Yookassa::Callable
    include Yookassa::Optional

    option :type, proc(&:to_s)
    option :id, proc(&:to_s), optional: true
    option :code, proc(&:to_s), optional: true
    option :description, proc(&:to_s), optional: true
    option :parameter, proc(&:to_s), optional: true

    def error?
      type == 'error'
    end

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
