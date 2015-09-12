class AddNotNullConstraintToListTitle < ActiveRecord::Migration
  def change
    change_column :lists, :title, :string, null: false
  end
end
