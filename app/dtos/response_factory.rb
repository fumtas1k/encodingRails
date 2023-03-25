require_relative "./dtos"

class ResponseFactory

  def self.create(customer_to_product_names)

    customers = customer_to_product_names.map do |code, product_names|
      Customer.new(
        code,
        product_names.map(&method(:create_product))
      )
    end

    Response.new("レスポンス", customer_to_product_names)
  end

  def self.create_product(name)
    Product.new(name, 1)
  end
end
