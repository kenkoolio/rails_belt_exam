class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :productable, polymorphic: true

  belongs_to :buyer, class_name: "User", foreign_key: "productable_id"

  validates :name, :amount, presence: true
end
