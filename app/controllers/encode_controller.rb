require_relative "../dtos/sample"
require_relative "../dtos/response_factory"

class EncodeController < ApplicationController
  after_action :convert_to_sjis, only: %i[get_data]

  Sample.extract_keys(Sample::SAMPLE_DATA).each do |key|
    param_encoding :get_data, key, Encoding::SJIS
  end

  def get_sample_data
    render json: Sample::SAMPLE_DATA
  end

  def get_data
    customer_to_product_names = extract_data
    render json: ResponseFactory.create(customer_to_product_names)
  end

  private
  def convert_to_sjis
    headers["Content-Type"] = "application/json; charset=Windows-31J"
    response.body = response.body.encode(Encoding::SJIS)
  end

  def extract_data
    params.dig(:encode, :customers)&.map do |customer|
      [
        customer[:code],
        customer[:products]&.map { _1[:name] }
      ]
    end.to_h || []
  end
end
