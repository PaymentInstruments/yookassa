# frozen_string_literal: true

RSpec.describe Yookassa do
  it "has a version number" do
    expect(Yookassa::VERSION).not_to be nil
  end

  before do
    Yookassa.configure do |config|
      config.shop_id = 123
      config.api_key = "test_321"
    end
  end

  describe ".configure" do
    it "stores settings and provides access to credentials" do
      expect(Yookassa.config.shop_id).to eq(123)
      expect(Yookassa.config.api_key).to eq("test_321")
    end
  end

  describe ".payments" do
    it "delegates request to client and creates an instance" do
      expect(Yookassa.payments).to be_a(Yookassa::Payments)
    end
  end

  describe ".refunds" do
    it "delegates request to client and creates an instance" do
      expect(Yookassa.refunds).to be_a(Yookassa::Refunds)
    end
  end

  describe ".receipts" do
    it "delegates request to client and creates an instance" do
      expect(Yookassa.receipts).to be_a(Yookassa::Receipts)
    end
  end
end
