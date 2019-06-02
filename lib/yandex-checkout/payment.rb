# frozen_string_literal: true

module YandexCheckout
  class Payment < Evil::Client
    option :shop_id,  proc(&:to_s)
    option :api_key,  proc(&:to_s)

    path { 'https://payment.yandex.net/api/v3' }
    security { basic_auth shop_id, api_key }

    # http_method { :get }
    scope :payments do
      operation :status do
        option :payment_id, proc(&:to_s)

        http_method :get
        path { "payments/#{payment_id}" }

        response 200 do |_status, _headers, body|
          p JSON.parse(*body)
        end

        # Parses json response, wraps it into model with [#error] and raises
        # an exception where [ResponseError#response] contains the model instance

        response(400, 422) do |(status, *)|
          raise "#{status}: Record invalid"
        end

        response(404) do |(_status, *)|
          p 'Record Not Found'
          # raise "#{status}: Record not found"
        end
      end

      operation :create do
        option :payment
        option :idempotency_key, optional: true

        http_method :post

        path { 'payments' }
        # query { { params: params } }
        format 'json'
        headers 'Idempotence-Key' => '244afbdc-000f-5000-a000-12526186ce10'
        body { payment }

        response 200 do |_status, _headers, body|
          p JSON.parse(*body)
        end

        # Parses json response, wraps it into model with [#error] and raises
        # an exception where [ResponseError#response] contains the model instance

        response(400, 422) do |(status, *)|
          raise "#{status}: Record invalid"
        end
      end
    end
  end
end
