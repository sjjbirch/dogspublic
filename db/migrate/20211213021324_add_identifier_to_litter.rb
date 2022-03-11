class AddIdentifierToLitter < ActiveRecord::Migration[6.1]
  def change
    add_column :litters, :identifier, :string
  end
end
