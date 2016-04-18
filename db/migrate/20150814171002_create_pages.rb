class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :url_key
      t.text :description
      t.text :meta_keys

      t.timestamps null: false
    end

    add_index :pages, :url_key, :unique => true
  end
end
