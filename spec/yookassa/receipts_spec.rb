# frozen_string_literal: true

RSpec.describe Yookassa::Receipts do
  let(:config) { { shop_id: "SHOP_ID", api_key: "API_KEY" } }
  let(:receipt) { described_class.new(**config) }
  let(:idempotency_key) { SecureRandom.hex(1) }
  let(:body) { File.read("spec/fixtures/receipt_response.json") }

  before { stub_request(:any, //).to_return(body: body, headers: { "Content-Type" => "application/json" }) }

  shared_examples "returns_receipt_object" do
    it "returns success" do
      expect(subject).to be_a Yookassa::Entity::Receipt
      expect(subject.id).to eq "rt_1da5c87d-0984-50e8-a7f3-8de646dd9ec9"
      expect(subject.payment_id).to eq "215d8da0-000f-50be-b000-0003308c89be"
      expect(subject.status).to eq "pending"
      expect(subject.items.count).to eq 2
      expect(subject.items.first).to be_kind_of Yookassa::Entity::Product
      expect(subject.settlements.count).to eq 2
      expect(subject.settlements.first).to be_kind_of Yookassa::Entity::Settlement
    end
  end

  describe "#create" do
    let(:payload) { JSON.parse(File.read("spec/fixtures/receipt_request.json")) }
    let(:url) { "https://api.yookassa.ru/v3/receipts" }

    subject { receipt.create(payload: payload, idempotency_key: idempotency_key) }

    it "sends a request" do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it_behaves_like "returns_receipt_object"
  end

  describe "#find" do
    let(:receipt_id) { "2490ded1-000f-5000-8000-1f64111bc63e" }
    let(:url) { "https://api.yookassa.ru/v3/receipts/#{receipt_id}" }

    subject { receipt.find(receipt_id: receipt_id) }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it_behaves_like "returns_receipt_object"
  end

  describe "#list" do
    let(:body) { File.read("spec/fixtures/list_receipt_response.json") }

    let(:filters) do
      {
        limit: 20,
        "created_at.gt": "2018-07-18T10:51:18.139Z"
      }
    end

    let(:url) { "https://api.yookassa.ru/v3/receipts?limit=20&created_at.gt=2018-07-18T10:51:18.139Z" }

    subject { receipt.list(filters: filters) }

    it "sends a request" do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it "returns a collection" do
      expect(subject).to be_a Yookassa::Entity::ReceiptCollection
    end
  end
end
