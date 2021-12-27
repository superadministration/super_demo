class Admin::OrdersController < AdminController
  private

  def model
    Order
  end

  def form_schema
    customers = Customer.all.map do |c|
      [c.name, c.id]
    end
    products = Product.all.map do |p|
      [p.name, p.id]
    end

    Super::Form.new do |f, type|
      f[:customer_id] = type.select(customers)
      f[:order_lines_attributes] = type.has_many(:order_lines) do |g|
        g[:product_id] = type.select(products)
        g[:_destroy] = type._destroy
      end
    end
  end
end
