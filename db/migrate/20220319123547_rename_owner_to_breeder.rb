class RenameOwnerToBreeder < ActiveRecord::Migration[6.1]
  def change
    rename_column :dogs, :owner, :breeder
  end
end
