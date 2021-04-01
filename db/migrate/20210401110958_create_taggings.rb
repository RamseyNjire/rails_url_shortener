class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|

      t.integer :topic_id, foreign_key: true, null: false
      t.integer :short_url_id, foreign_key: true, null: false

      t.timestamps
    end
    add_index :taggings, %i(topic_id short_url_id), unique: true
    add_index :taggings, :short_url_id
  end
end
