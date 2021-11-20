# frozen_string_literal: true

require_relative "./client"
require_relative "./entity/store_info"

module Yookassa
  class Stores < Client
    def info
      data = get("me")
      Entity::StoreInfo.new(**data)
    end
  end
end
