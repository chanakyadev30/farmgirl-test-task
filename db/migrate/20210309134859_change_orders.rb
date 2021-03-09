class ChangeOrders < ActiveRecord::Migration[6.0]
  def up
    drop_table :orders

    create_table :orders do |t|
      t.integer :status, default: 0
      t.references :fulfiller, polymorphic: true
      t.timestamps

      # indexed status
      t.index :status
    end
  end

  def down
    drop_table :orders

    enable_extension 'pgcrypto'
    # used uuid
    create_table :orders, id: :uuid do |t|
      t.integer :status, default: 0
      t.references :fulfiller, polymorphic: true
      t.timestamps

      # indexed status
      t.index :status
    end
  end
end
