class AttributeOption < ActiveRecord::Migration
  def change
    create_table    :attribute_option do |t|
      t.belongs_to  :attributes
      t.integer     :attribute_id, null: false
      t.string      :value, null: false
      t.string      :label, null: false
      t.integer     :position, default: 0
      t.timestamps  null: false
    end
  end
end
