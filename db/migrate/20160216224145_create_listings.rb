class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.integer :type_id

      t.timestamps null: false
    end
    add_index :listings, :user_id
  end
end
