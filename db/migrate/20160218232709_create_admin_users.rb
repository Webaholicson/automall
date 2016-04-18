class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :password
      t.string    :email
      t.string    :username
      t.integer   :login_count, default: 0, null: false
      t.integer   :failed_login_count, default: 0, null: false
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.boolean   :active, default: false
      t.boolean   :blocked, default: false
      t.string    :approval_code
      t.boolean   :must_change_password, default: false

      t.timestamps null: false
    end

    add_index :admin_users, :email, :unique => true
    add_index :admin_users, :username, :unique => true
  end
end
