class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 5, scale: 2, default: 0 # for future reference
      t.text :description
      t.timestamps
    end
  end
end
