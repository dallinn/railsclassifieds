class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :limit => 25
      t.string :last_name, :limit => 50
      t.string :email, :limit => 100
      t.string :username, :limit => 25
      t.string :password_digest
      t.string :remember_digest

      t.timestamps null: false
    end
  end
end
