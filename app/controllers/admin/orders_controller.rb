class Admin::OrdersController < AdminController
  private

  def model
    Order
  end

  def base_scope
    model.preload(:customer, :products)
  end

  def display_schema
    Super::Display.new do |f, type|
      f[:id] = type.batch
      f[:customer_id] = type.real(:record) { |record| record.customer.name }
      if current_action.index?
        f[:number_of_order_lines] = type.computed(:record) { |record| record.order_lines.size }
      else
        f[:products] = type.computed(:record) { |record| record.products.map(&:name).join(", ") }
        f[:updated_at] = type.timestamp
        f[:created_at] = type.timestamp
      end
    end
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
