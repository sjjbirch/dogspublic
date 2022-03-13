class AddDogToAdvert < ActiveRecord::Migration[6.1]
  def change
    add_reference :adverts, :dog, null: false, foreign_key: true
  end
end
