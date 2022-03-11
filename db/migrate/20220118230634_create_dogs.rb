class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.string :rname
      t.string :cname
      t.date :dob
      t.string :owner
      t.string :handler
      t.string :sex, limit: 1
      t.string :status, limit: 10

      t.timestamps
    end
  end
end

# 