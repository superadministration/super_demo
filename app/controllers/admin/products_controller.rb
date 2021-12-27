class Admin::ProductsController < AdminController
  private

  def model
    Product
  end

  def display_schema
    Super::Display.new do |f, type|
      f[:id] = type.batch
      f[:name] = type.string
      f[:price_cents] = type.real(:column) { |val| val = val.to_s.rjust(3, "0") ; "$#{val[0..-3]}.#{val[-2..-1]}" }
      if current_action.show?
        f[:order_lines_quantity] = type.computed(:record) { |record| record.order_lines.size }
      end
      f[:created_at] = type.timestamp
      if current_action.show?
        f[:updated_at] = type.timestamp
      end
    end
  end
end
