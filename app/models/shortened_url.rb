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

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :visited_url_id,
        primary_key: :id
    )

    has_many(
        -> { distinct }
        :visitors,
        through: :visits,
        source: :visitor
    )

    def self.random_code
        begin
            short_url = SecureRandom.urlsafe_base64
        end while exists?(short_url: short_url)
        short_url
    end

    def self.create_shortened_url!(user, long_url)
        ShortenedUrl.create!(
        user_id: user.id,
        long_url: long_url,
        short_url: ShortenedUrl.random_code
        )
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end

    def num_recent_uniques
        visits.where("created_at < ?", 10.minutes.ago).count
    end
end
