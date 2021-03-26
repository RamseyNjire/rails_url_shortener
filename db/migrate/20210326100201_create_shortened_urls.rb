class CreateShortenedUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :shortened_urls do |t|

      t.string :long_url
      t.string :short_url, index: true, unique: true
      t.integer :user_id, foreign_key: true

      t.timestamps
    end
  end
end
