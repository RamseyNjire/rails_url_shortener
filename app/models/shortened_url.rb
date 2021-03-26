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

    
    
    def shorten_url(submitter, long_url)
        shortened_url = create!(long_url: long_url, short_url: random_code(long_url))
        submitter.shortened_urls << shortened_url
    end
    
    private
    
    
    def random_code(long_url)
        begin
            short_url = SecureRandom.urlsafe_base64(long_url)
        end while exists?(short_url: short_url)
        short_url
    end
end
