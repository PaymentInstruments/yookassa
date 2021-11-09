# frozen_string_literal: true

RSpec.describe Yookassa::Contracts::PaymentContract do
  let(:data) { JSON.load_file("spec/fixtures/create_payment.json", symbolize_names: true) }
  let(:contract) { described_class.new.call(data) }

  it do
    # binding.pry
    expect(contract).to be_success
  end
end
