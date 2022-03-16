class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :amount
      t.datetime :transaction_time
      t.integer :dogsold
      t.references :seller, null: false#, foreign_key: true
      t.references :buyer, null: false#, foreign_key: true

      t.timestamps
    end
    add_foreign_key :payments, :users, column: :seller_id
    add_foreign_key :payments, :users, column: :buyer_id
  end
end
