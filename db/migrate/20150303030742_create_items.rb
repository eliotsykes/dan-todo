class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
    add_foreign_key :items, :users
  end
end
