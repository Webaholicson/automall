class Attribute < ActiveRecord::Migration
  def change
    create_table  :attribute do |t|
      t.integer   :type_id, null: false
      t.string    :name, null: false
      t.string    :label, null: false
      t.text      :description, null: true
      t.string    :type, null: false
      t.boolean   :required, null: true, default: false
      t.timestamps null: false
    end
    add_index :attribute, :type_id
  end
end
