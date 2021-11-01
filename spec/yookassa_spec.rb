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

  describe ".client" do
    context "when no settings are provided" do
      before { Yookassa.instance_variable_set(:@config, nil) }

      it "raises an error" do
        expect { Yookassa.client }.to raise_error(Yookassa::ConfigError)
      end
    end

    context "when instance configured" do
      it "creates and stores client" do
        expect(Yookassa.client).to be_a(Yookassa::Client)
        expect(Yookassa.client).to eq(Yookassa.client)
      end
    end
  end

  describe ".payments" do
    it "delegates request to client and creates an instance" do
      expect(Yookassa.payments).to be_a(Yookassa::Payments)
    end
  end
end
