class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :productable, polymorphic: true

  validates :name, :amount, presence: true
end
