# frozen_string_literal: true

module Yookassa
  class Response
    extend Dry::Initializer
    option :id, proc(&:to_s)
    option :status, proc(&:to_s), default: proc {}

    class << self
      def build(*res)
        body = res.last
        new JSON.parse(body.first)
      end

      def new(opts)
        super opts.transform_keys(&:to_sym)
      end
    end
  end
end
