# frozen_string_literal: true

RSpec.describe Yookassa::Refunds do
  let(:config) { { shop_id: "SHOP_ID", api_key: "API_KEY" } }
  let(:client) { Yookassa::Client.new(**config) }
  let(:idempotency_key) { SecureRandom.hex(1) }
  let(:refund) { client.refunds }
  let(:body) { File.read("spec/fixtures/refund_response.json") }

  before { stub_request(:any, //).to_return(body: body, headers: { "Content-Type" => "application/json" }) }

  shared_examples "returns_refund_object" do
    it "returns success" do
      expect(subject).to be_a Yookassa::Entity::Refund
      expect(subject.id).to eq "2491ab0c-0015-5000-9000-1640c7f1a6f0"
      expect(subject.payment_id).to eq "2491a6e2-000f-5000-9000-1480e820ae17"
      expect(subject.status).to eq "succeeded"
      expect(subject.created_at).to eq "2019-06-11T11:58:04.502Z"
      expect(subject.description).to eq "test refund, idem-key 78c95366-ec4b-4284-a0fd-41e694bcdf11"

      expect(subject.amount).to be_kind_of Yookassa::Entity::Amount
      expect(subject.amount.currency).to eq "RUB"
      expect(subject.amount.value).to eq 8.0
    end
  end

  describe "#create" do
    let(:payload) { JSON.parse(File.read("spec/fixtures/refund_request.json")) }
    let(:url) { "https://api.yookassa.ru/v3/refunds" }

    subject { refund.create(payload: payload, idempotency_key: idempotency_key) }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it_behaves_like "returns_refund_object"
  end

  describe "#find" do
    let(:payment_id) { "2490ded1-000f-5000-8000-1f64111bc63e" }
    let(:url) { "https://api.yookassa.ru/v3/refunds/#{payment_id}" }

    subject { refund.find(payment_id: payment_id) }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it_behaves_like "returns_refund_object"
  end

  describe "#list" do
    let(:body) { File.read("spec/fixtures/list_refund_response.json") }

    let(:filters) do
      {
        limit: 20,
        "created_at.gt": "2018-07-18T10:51:18.139Z"
      }
    end

    let(:url) { "https://api.yookassa.ru/v3/refunds?limit=20&created_at.gt=2018-07-18T10:51:18.139Z" }

    subject { refund.list(filters: filters) }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it "returns a collection" do
      expect(subject).to be_a Yookassa::Entity::RefundCollection
    end
  end
end
