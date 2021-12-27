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
    end
  end

  def self.reset_tables
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE order_lines RESTART IDENTITY CASCADE")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE orders RESTART IDENTITY CASCADE")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE products RESTART IDENTITY CASCADE")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE customers RESTART IDENTITY CASCADE")
  end
end
