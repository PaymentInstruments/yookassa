# frozen_string_literal: true

RSpec.describe Yookassa do
  it "has a version number" do
    expect(Yookassa::VERSION).not_to be nil
  end

  describe ".configure" do
    before do
      Yookassa.configure do |config|
        config.shop_id = 123
        config.api_key = "test_321"
      end
    end

    it "stores settings and provides access to credentials" do
      expect(Yookassa.config.shop_id).to eq(123)
      expect(Yookassa.config.api_key).to eq("test_321")
    end
  end
end
