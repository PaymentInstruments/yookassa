# frozen_string_literal: true

require_relative './entity/store_info'

module Yookassa
  class Stores
    def initialize(partner_api)
      @partner_api = partner_api
    end

    def me
      data = partner_api.get("me")
      Entity::StoreInfo.new(**data)
    end

    private

    attr_reader :partner_api
  end
end
