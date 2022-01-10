require "test_helper"

class RunthroughTest < ActionDispatch::IntegrationTest
  test "orders" do
    get admin_root_path
    assert_redirected_to admin_orders_path

    get admin_orders_path
    assert_response :success

    get admin_order_path(Order.first)
    assert_response :success

    get new_admin_order_path
    assert_response :success

    get edit_admin_order_path(Order.first)
    assert_response :success

    assert_changes "Order.first.customer_id", from: Customer.first.id, to: Customer.last.id do
      put admin_order_path(Order.first), params: { order: { customer_id: Customer.last.id } }
    end
    assert_redirected_to admin_order_path(Order.first)

    assert_difference "Order.count", -1 do
      delete admin_order_path(Order.last)
    end
    assert_redirected_to admin_orders_path

    assert_difference "Order.count", 1 do
      post admin_orders_path, params: { order: { customer_id: Customer.first.id } }
    end
    assert_redirected_to admin_order_path(Order.last)
  end

  test "customers" do
    get admin_customers_path
    assert_response :success

    get admin_customer_path(Customer.first)
    assert_response :success

    get new_admin_customer_path
    assert_response :success

    get edit_admin_customer_path(Customer.first)
    assert_response :success

    assert_changes "Customer.first.name", from: Customer.first.name, to: "Evil Emperor Zurg" do
      put admin_customer_path(Customer.first), params: { customer: { name: "Evil Emperor Zurg" } }
    end
    assert_redirected_to admin_customer_path(Customer.first)

    assert_difference "Customer.count", -1 do
      delete admin_customer_path(Customer.last)
    end
    assert_redirected_to admin_customers_path

    assert_difference "Customer.count", 1 do
      post admin_customers_path, params: { customer: { name: "Buzz Lightyear" } }
    end
    assert_redirected_to admin_customer_path(Customer.last)
  end

  test "products" do
    get admin_products_path
    assert_response :success

    get admin_product_path(Product.first)
    assert_response :success

    get new_admin_product_path
    assert_response :success

    get edit_admin_product_path(Product.first)
    assert_response :success

    assert_changes "Product.first.name", from: Product.first.name, to: "Little Green Men" do
      put admin_product_path(Product.first), params: { product: { name: "Little Green Men" } }
    end
    assert_redirected_to admin_product_path(Product.first)

    assert_difference "Product.count", -1 do
      delete admin_product_path(Product.last)
    end
    assert_redirected_to admin_products_path

    assert_difference "Product.count", 1 do
      post admin_products_path, params: { product: { name: "Buzz Lightyear", price_cents: 12345 } }
    end
    assert_redirected_to admin_product_path(Product.last)
  end
end
