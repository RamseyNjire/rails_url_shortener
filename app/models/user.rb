class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true

    has_many(
        :submitted_urls,
        class_name: 'ShortenedUrl',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :visitor_id,
        primary_key: :id
    )

    has_many(
        -> { distinct }
        :visited_urls,
        through: :visits,
        source: :visited_url
    )
end
