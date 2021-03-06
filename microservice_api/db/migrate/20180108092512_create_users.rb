class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
    add_index :users, :email
  end
end
