class ChangeOrderItems < ActiveRecord::Migration[6.0]
  def up
    drop_table :order_items

    create_table :order_items do |t|
      t.integer :quantity, default: 1
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :order_items

    create_table :order_items, id: :uuid do |t|
      t.integer :quantity, default: 1
      t.references :order, type: :uuid, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
