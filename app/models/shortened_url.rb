require 'securerandom'
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, uniqueness: true

    belongs_to(
        :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )
    
    def self.random_code
        begin
            short_url = SecureRandom.urlsafe_base64
        end while exists?(short_url: short_url)
        short_url
    end
end
