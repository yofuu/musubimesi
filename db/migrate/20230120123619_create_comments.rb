class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :item_id
      t.integer :customer_id
      t.string :body

      t.timestamps
    end
  end
end
