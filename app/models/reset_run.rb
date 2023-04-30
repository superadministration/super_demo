class ResetRun < ApplicationRecord
  def self.reset
    ActiveRecord::Base.transaction do
      reset_tables
      clean = YAML.load(Rails.root.join("db/seeds.yml").read)

      Product.insert_all(clean["products"])
      Customer.insert_all(clean["customers"])
      clean["orders"].in_groups_of(1000, false).each do |group|
        Order.insert_all(group)
      end
      clean["order_lines"].in_groups_of(1000, false).each do |group|
        OrderLine.insert_all(group)
      end

      ResetRun.order(id: :desc).offset(2000).delete_all
    end
  end

  def self.reset_tables
    ActiveRecord::Base.connection.execute("DELETE FROM order_lines")
    ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='order_lines'")
    ActiveRecord::Base.connection.execute("DELETE FROM orders")
    ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='orders'")
    ActiveRecord::Base.connection.execute("DELETE FROM products")
    ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products'")
    ActiveRecord::Base.connection.execute("DELETE FROM customers")
    ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='customers'")
  end
end
