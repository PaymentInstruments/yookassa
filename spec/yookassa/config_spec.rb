# frozen_string_literal: true

RSpec.describe Yookassa::Config do
  subject { described_class.new }
  it { is_expected.to respond_to(:shop_id) }
  it { is_expected.to respond_to(:api_key) }
end
