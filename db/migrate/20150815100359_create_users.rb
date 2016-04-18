class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :password
      t.string    :about
      t.text      :phone
      t.string    :email
      t.integer   :login_count, default: 0, null: false
      t.integer   :failed_login_count, default: 0, null: false
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.boolean   :active, default: false
      t.string    :approval_code
      t.boolean   :confirmed, default: false

      t.timestamps null: false
    end

    add_index :users, :email, :unique => true
  end
end
