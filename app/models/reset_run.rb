class ResetRun < ApplicationRecord
  def self.reset
    ActiveRecord::Base.transaction do
      reset_tables
      clean = YAML.load(Rails.root.join("db/seeds.yml").read)

      Product.insert_all(clean["products"])
      Customer.insert_all(clean["customers"])
      Order.insert_all(clean["orders"])
      OrderLine.insert_all(clean["order_lines"])
    end
  end

  def self.reset_tables
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE order_lines RESTART IDENTITY CASCADE")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE orders RESTART IDENTITY CASCADE")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE products RESTART IDENTITY CASCADE")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE customers RESTART IDENTITY CASCADE")
  end
end
