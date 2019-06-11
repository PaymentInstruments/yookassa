# frozen_string_literal: true

RSpec.describe YandexCheckout::Payment do
  describe '#create' do
    let(:settings) { { shop_id: 'SHOP_ID', api_key: 'API_KEY' } }
    let(:idempotence_key) { 12_345 }
    let(:payment) { described_class.new(settings) }
    let(:params) { { payment: File.read('spec/fixtures/payment.json') } }
    let(:url) { 'https://payment.yandex.net/api/v3/payments' }
    let(:body) { File.read('spec/fixtures/payment_response.json') }

    before  { stub_request(:any, //).to_return(body: body) }
    subject { payment.create(payment: params, idempotency_key: idempotence_key) }

    it 'sends a request' do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it 'returns success' do
      expect(subject).to be_kind_of YandexCheckout::Response
      expect(subject.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.test).to eq true
      expect(subject.paid).to eq false
      expect(subject.status).to eq 'pending'
      expect(subject.captured_at).to eq nil
      expect(subject.created_at).to eq '2019-06-10T21:26:41.395Z'
      expect(subject.description).to eq nil
      expect(subject.expires_at).to eq nil
      expect(subject.metadata).to eq Hash[]

      expect(subject.amount).to be_kind_of YandexCheckout::Entity::Amount
      expect(subject.amount.currency).to eq 'RUB'
      expect(subject.amount.value).to eq 10.0

      expect(subject.confirmation).to be_kind_of YandexCheckout::Entity::Confirmation
      expect(subject.confirmation.confirmation_url).to eq 'https://money.yandex.ru/payments/external/confirmation?orderId=2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.confirmation.type).to eq 'redirect'
      expect(subject.confirmation.return_url).to eq 'https://url.test'
      expect(subject.confirmation.enforce).to eq nil

      expect(subject.payment_method).to be_kind_of YandexCheckout::Entity::PaymentMethod
      expect(subject.payment_method.card).to eq nil
      expect(subject.payment_method.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.payment_method.saved).to eq false
      expect(subject.payment_method.type).to eq 'bank_card'
      expect(subject.payment_method.title).to eq nil
    end
  end

  describe '#get_payment_info' do
    let(:settings) { { shop_id: 'SHOP_ID', api_key: 'API_KEY' } }
    let(:payment_id) { '2490ded1-000f-5000-8000-1f64111bc63e' }
    let(:payment) { described_class.new(settings) }
    let(:url) { "https://payment.yandex.net/api/v3/payments/#{payment_id}" }
    let(:body) { File.read('spec/fixtures/payment_response.json') }

    before  { stub_request(:any, //).to_return(body: body) }
    subject { payment.get_payment_info(payment_id: payment_id) }

    it 'sends a request' do
      subject
      expect(a_request(:get, url)).to have_been_made
    end

    it 'returns success' do
      expect(subject).to be_kind_of YandexCheckout::Response
      expect(subject.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.test).to eq true
      expect(subject.paid).to eq false
      expect(subject.status).to eq 'pending'
      expect(subject.captured_at).to eq nil
      expect(subject.created_at).to eq '2019-06-10T21:26:41.395Z'
      expect(subject.description).to eq nil
      expect(subject.expires_at).to eq nil
      expect(subject.metadata).to eq Hash[]

      expect(subject.amount).to be_kind_of YandexCheckout::Entity::Amount
      expect(subject.amount.currency).to eq 'RUB'
      expect(subject.amount.value).to eq 10.0

      expect(subject.confirmation).to be_kind_of YandexCheckout::Entity::Confirmation
      expect(subject.confirmation.confirmation_url).to eq 'https://money.yandex.ru/payments/external/confirmation?orderId=2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.confirmation.type).to eq 'redirect'
      expect(subject.confirmation.return_url).to eq 'https://url.test'
      expect(subject.confirmation.enforce).to eq nil

      expect(subject.payment_method).to be_kind_of YandexCheckout::Entity::PaymentMethod
      expect(subject.payment_method.card).to eq nil
      expect(subject.payment_method.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.payment_method.saved).to eq false
      expect(subject.payment_method.type).to eq 'bank_card'
      expect(subject.payment_method.title).to eq nil
    end
  end

  describe '#capture' do
    let(:settings) { { shop_id: 'SHOP_ID', api_key: 'API_KEY' } }
    let(:idempotence_key) { 12_345 }
    let(:payment) { described_class.new(settings) }
    let(:payment_id) { '2490ded1-000f-5000-8000-1f64111bc63e' }
    let(:params) { { payment: File.read('spec/fixtures/payment.json') } }
    let(:url) { "https://payment.yandex.net/api/v3/payments/#{payment_id}/capture" }
    let(:body) { File.read('spec/fixtures/payment_response.json') }

    before  { stub_request(:any, //).to_return(body: body) }
    subject { payment.capture(payment_id: payment_id, idempotency_key: idempotence_key) }

    it 'sends a request' do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it 'returns success' do
      expect(subject).to be_kind_of YandexCheckout::Response
      expect(subject.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.test).to eq true
      expect(subject.paid).to eq false
      expect(subject.status).to eq 'pending'
      expect(subject.captured_at).to eq nil
      expect(subject.created_at).to eq '2019-06-10T21:26:41.395Z'
      expect(subject.description).to eq nil
      expect(subject.expires_at).to eq nil
      expect(subject.metadata).to eq Hash[]

      expect(subject.amount).to be_kind_of YandexCheckout::Entity::Amount
      expect(subject.amount.currency).to eq 'RUB'
      expect(subject.amount.value).to eq 10.0

      expect(subject.confirmation).to be_kind_of YandexCheckout::Entity::Confirmation
      expect(subject.confirmation.confirmation_url).to eq 'https://money.yandex.ru/payments/external/confirmation?orderId=2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.confirmation.type).to eq 'redirect'
      expect(subject.confirmation.return_url).to eq 'https://url.test'
      expect(subject.confirmation.enforce).to eq nil

      expect(subject.payment_method).to be_kind_of YandexCheckout::Entity::PaymentMethod
      expect(subject.payment_method.card).to eq nil
      expect(subject.payment_method.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.payment_method.saved).to eq false
      expect(subject.payment_method.type).to eq 'bank_card'
      expect(subject.payment_method.title).to eq nil
    end
  end

  describe '#cancel' do
    let(:settings) { { shop_id: 'SHOP_ID', api_key: 'API_KEY' } }
    let(:idempotence_key) { 12_345 }
    let(:payment_id) { '2490ded1-000f-5000-8000-1f64111bc63e' }
    let(:payment) { described_class.new(settings) }
    # let(:params) { { payment: File.read('spec/fixtures/payment.json') } }
    let(:url) { "https://payment.yandex.net/api/v3/payments/#{payment_id}/cancel" }
    let(:body) { File.read('spec/fixtures/payment_response.json') }

    before  { stub_request(:any, //).to_return(body: body) }
    subject { payment.cancel(payment_id: payment_id, idempotency_key: idempotence_key) }

    it 'sends a request' do
      subject
      expect(a_request(:post, url)).to have_been_made
    end

    it 'returns success' do
      expect(subject).to be_kind_of YandexCheckout::Response
      expect(subject.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.test).to eq true
      expect(subject.paid).to eq false
      expect(subject.status).to eq 'pending'
      expect(subject.captured_at).to eq nil
      expect(subject.created_at).to eq '2019-06-10T21:26:41.395Z'
      expect(subject.description).to eq nil
      expect(subject.expires_at).to eq nil
      expect(subject.metadata).to eq Hash[]

      expect(subject.amount).to be_kind_of YandexCheckout::Entity::Amount
      expect(subject.amount.currency).to eq 'RUB'
      expect(subject.amount.value).to eq 10.0

      expect(subject.confirmation).to be_kind_of YandexCheckout::Entity::Confirmation
      expect(subject.confirmation.confirmation_url).to eq 'https://money.yandex.ru/payments/external/confirmation?orderId=2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.confirmation.type).to eq 'redirect'
      expect(subject.confirmation.return_url).to eq 'https://url.test'
      expect(subject.confirmation.enforce).to eq nil

      expect(subject.payment_method).to be_kind_of YandexCheckout::Entity::PaymentMethod
      expect(subject.payment_method.card).to eq nil
      expect(subject.payment_method.id).to eq '2490ded1-000f-5000-8000-1f64111bc63e'
      expect(subject.payment_method.saved).to eq false
      expect(subject.payment_method.type).to eq 'bank_card'
      expect(subject.payment_method.title).to eq nil
    end
  end
end
