class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :email
      t.integer :phone, limit:8
      t.string  :gender
      t.string  :password_digest

      t.timestamps null: false
    end
  end
end
