class Product < ApplicationRecord
  has_many :order_lines, dependent: :destroy
  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
