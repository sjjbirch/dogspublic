class CreateAdverts < ActiveRecord::Migration[6.1]
  def change
    create_table :adverts do |t|
      t.text :title
      t.text :description

      t.timestamps
    end
  end
end
