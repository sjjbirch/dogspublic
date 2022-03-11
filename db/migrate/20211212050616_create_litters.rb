class CreateLitters < ActiveRecord::Migration[6.1]
  def change
    create_table :litters do |t|
      t.date :planned_date
      t.date :expected_date
      t.date :actual_date
      t.integer :expected_size
      t.integer :actual_size

      t.timestamps
    end
  end
end
