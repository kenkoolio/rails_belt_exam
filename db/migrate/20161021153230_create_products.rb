class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.decimal :amount
      t.references :productable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
