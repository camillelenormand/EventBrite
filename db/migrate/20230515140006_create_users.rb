class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :description
      t.string :first_name
      t.string :last_name
      t.string :encrypted_password, null: false, default: ""

      t.timestamps
    end
  end
end
