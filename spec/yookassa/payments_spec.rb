# frozen_string_literal: true

RSpec.describe Yookassa::Payments do
  let(:config) { { shop_id: "SHOP_ID", api_key: "API_KEY" } }
  let(:client) { Yookassa::Client.new(**config) }
  let(:idempotency_key) { SecureRandom.hex(1) }

  let(:payment) { client.payments }
  let(:body) { File.read("spec/fixtures/payment_response.json") }

  before { stub_request(:any, //).to_return(body: body, headers: { "Content-Type" => "application/json" }) }

  shared_examples "returns_payment_object" do
    it "returns success" do
      expect(subject).to be_a Yookassa::Entity::Payment
      expect(subject.id).to eq "2490ded1-000f-5000-8000-1f64111bc63e"
      expect(subject.test).to eq true
      expect(subject.paid).to eq false
      expect(subject.status).to eq "pending"
      expect(subject.captured_at).to eq nil
      expect(subject.created_at).to eq DateTime.parse("2019-06-10T21:26:41.395Z")
      expect(subject.description).to eq nil
      expect(subject.expires_at).to eq nil
      expect(subject.metadata).to eq({})

      expect(subject.amount).to be_a Yookassa::Entity::Amount
      expect(subject.amount.currency).to eq "RUB"
      expect(subject.amount.value).to eq 10.0

      expect(subject.confirmation).to be_a Yookassa::Entity::Confirmation
      expect(subject.confirmation.confirmation_url).to eq "https://money.yookassa.ru/payments/external/confirmation?orderId=2490ded1-000f-5000-8000-1f64111bc63e"
      expect(subject.confirmation.type).to eq "redirect"
      expect(subject.confirmation.return_url).to eq "https://url.test"
      expect(subject.confirmation.enforce).to eq nil

      expect(Yookassa::Entity::PaymentMethods.valid?(subject.payment_method)).to be_truthy
      expect(subject.payment_method).to be_a(Yookassa::Entity::PaymentMethod::BankCard)
      expect(subject.payment_method.card).to eq nil
      expect(subject.payment_method.id).to eq "2490ded1-000f-5000-8000-1f64111bc63e"
      expect(subject.payment_method.saved).to eq false
      expect(subject.payment_method.type).to eq "bank_card"
      expect(subject.payment_method.title).to eq nil
    end
  end

  describe "#create" do
    let(:params) { JSON.parse(File.read("spec/fixtures/payment.json")) }
    let(:url) { "https://api.yookassa.ru/v3/payments" }

    subject { payment.create(payment: params, idempotency_key: idempotency_key) }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it_behaves_like "returns_payment_object"
  end

  describe "#find" do
    let(:payment_id) { "2490ded1-000f-5000-8000-1f64111bc63e" }
    let(:url) { "https://api.yookassa.ru/v3/payments/#{payment_id}" }

    subject { payment.find(payment_id: payment_id) }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it_behaves_like "returns_payment_object"
  end

  describe "#capture" do
    let(:payment_id) { "2490ded1-000f-5000-8000-1f64111bc63e" }
    let(:url) { "https://api.yookassa.ru/v3/payments/#{payment_id}/capture" }

    subject { payment.capture(payment_id: payment_id, idempotency_key: idempotency_key) }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it_behaves_like "returns_payment_object"
  end

  describe "#cancel" do
    let(:payment_id) { "2490ded1-000f-5000-8000-1f64111bc63e" }
    let(:url) { "https://api.yookassa.ru/v3/payments/#{payment_id}/cancel" }

    subject { payment.cancel(payment_id: payment_id, idempotency_key: idempotency_key) }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it_behaves_like "returns_payment_object"
  end
end
