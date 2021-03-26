class AddNullFalseToShortenedUrls < ActiveRecord::Migration[6.1]
  def change
    change_column_null :shortened_urls, :long_url, false
  end
end
