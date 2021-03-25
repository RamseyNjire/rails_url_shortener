class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.text :email, index: true, unique: true

      t.timestamps
    end
  end
end
