require "test_helper"

class ResetJobTest < ActiveJob::TestCase
  test "it runs when there are no ResetRuns" do
    ResetRun.delete_all
    Customer.create!(name: "Ed")
    ResetJob.perform_now
    assert_not_predicate Customer.where(name: "Ed"), :exists?
    assert_equal 5, Product.count
    assert_equal 500, Customer.count
    assert_equal 1110, Order.count
    assert_equal 3343, OrderLine.count
  end

  test "it doesn't run when a ResetRun ran recently" do
    ResetRun.create!
    Customer.create!(name: "Ed")
    ResetJob.perform_now
    assert_predicate Customer.where(name: "Ed"), :exists?
  end
end
