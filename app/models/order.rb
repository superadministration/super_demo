class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_lines, dependent: :destroy
end
