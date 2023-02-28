class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :introduction
      t.boolean :is_active, default: true
      t.integer :customer_id
      t.integer :genre_id


      t.timestamps
    end
  end
end
