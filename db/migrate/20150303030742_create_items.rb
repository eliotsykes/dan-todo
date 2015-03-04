class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :name
      t.references :list, index: true

      t.timestamps
    end
  end
end