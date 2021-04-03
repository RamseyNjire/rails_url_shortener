require 'securerandom'
class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, uniqueness: true
    validate :no_spamming
    validate :non_premium_max

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
        :visitors,
        -> { distinct },
        through: :visits,
        source: :visitor
    )

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :short_url_id,
        primary_key: :id
    )

    has_many(
        :tag_topics,
        -> { distinct },
        through: :taggings,
        source: :tag_topic
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
        visits.where("created_at > ?", 10.minutes.ago).count
    end

    private
    def no_spamming
        last_minute = ShortenedUrl
        .where('created_at >= ?', 1.minute.ago)
        .where(user_id: submitter.id)
        .length

        errors[:maximum_exceeded] << 'of five short urls per minute' if last_minute >= 5
    end

    def nonpremium_max
        return if User.find(self.user_id).premium

        number_of_urls =
        ShortenedUrl
            .where(user_id: submitter.id)
            .length

        if number_of_urls >= 5
        errors[:Only] << 'premium members can create more than 5 short urls'
        end
    end
end
