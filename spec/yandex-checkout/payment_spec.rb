# frozen_string_literal: true

RSpec.describe YandexCheckout::Payment do
  describe '#make_payment' do
    let(:settings) { { shop_id: 'SHOP_ID', api_key: 'API_KEY' } }
    let(:idempotence_key) { 123 }
    let(:payment) { described_class.new(settings) }
    let(:params)   { { payment: File.read('spec/fixtures/payment.json') } }
    let(:answer)   { { result: 'accepted' } }

    before  { stub_request(:any, //).to_return(body: answer.to_json) }
    subject { payment.create(params) }

    context 'using ssl via POST:' do
      let(:url) { 'https://payment.yandex.net/api/v3/payments' }

      it 'sends a request' do
        # binding.pry
        subject
        expect(a_request(:post, url)).to have_been_made
      end

      it 'returns success' do
        expect(subject).to be_kind_of YandexCheckout::Response
        expect(subject.result).to eq 'accepted'
      end
    end
  end
end
