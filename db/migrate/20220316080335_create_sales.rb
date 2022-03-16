class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.integer :value
      t.references :seller_id, null: false, foreign_key: true
      t.references :buyer_id, null: false, foreign_key: true
      t.datetime :transaction_time
      t.integer :dogsold

      t.timestamps
    end
  end
end
