class Tagging < ApplicationRecord
    belongs_to(
        :tag_topic,
        class_name: 'TagTopic',
        foreign_key: :topic_id,
        primary_key: :id
    )

    belongs_to(
        :short_url,
        class_name: 'ShortenedUrl',
        foreign_key: :short_url_id,
        primary_key: :id
    )
end
