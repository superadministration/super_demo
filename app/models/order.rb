class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_lines, dependent: :destroy
  has_many :products, through: :order_lines
  accepts_nested_attributes_for :order_lines, reject_if: -> (attrs) { attrs["product_id"].blank? }
end
