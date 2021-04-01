class TagTopic < ApplicationRecord
    validates :name, presences: true, uniqueness: true

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :topic_id,
        primary_key: :id
    )

    has_many(
        :short_urls,
        -> { distinct },
        through: :taggings,
        source: :short_url
    )
end
