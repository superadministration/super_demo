ActiveRecord::Base.transaction do
  srand 139
  calculator = Product.create!(name: "Graphing calculator", price_cents: 100_00)
  cheeseburger = Product.create!(name: "Cheeseburger", price_cents: 6_00)
  magazine = Product.create!(name: "Magazine", price_cents: 3_00)
  sneakers = Product.create!(name: "Sneakers", price_cents: 55_00)
  tote = Product.create!(name: "Tote", price_cents: 20_00)
  products = [calculator, cheeseburger, magazine, sneakers, tote]

  (0...1000).each do |i|
    puts "Creating Customers #{i + 1} to #{i + 100}" if i % 100 == 0
    name = %w[Alice Bob Carol Dan][i % 4]
    Customer.create!(name: "#{name} #{i}")
  end

  Customer.order(:id).find_each do |customer|
    puts "Creating Orders for Customers #{customer.id} to #{customer.id + 99}" if customer.id % 100 == 1
    number_of_orders = rand(1..3)
    number_of_orders.times do
      order = customer.orders.build
      order_products = products.sample(rand(1..products.size))
      order_products.each do |product|
        order.order_lines.build(product: product)
      end
      order.save!
    end
  end
end

clean = {
  "products" => Product.all.as_json(only: [:id, :name, :price_cents]),
  "customers" => Customer.all.as_json(only: [:id, :name]),
  "orders" => Order.all.as_json(only: [:id, :customer_id]),
  "order_lines" => OrderLine.all.as_json(only: [:id, :order_id, :product_id]),
}

Rails.root.join("db/seeds.yml").write(YAML.dump(clean))
