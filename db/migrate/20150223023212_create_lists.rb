class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.references :user, index: true

      t.timestamps
    end
    add_foreign_key :lists, :users
  end
end
