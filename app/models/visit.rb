class Visit < ApplicationRecord

    belongs_to(
        :visitor,
        class_name: 'User',
        foreign_key: :visitor_id,
        primary_key: :id
    )

    belongs_to(
        :visited_url,
        class_name: 'ShortenedUrl',
        foreign_key: :visited_url_id,
        primary_key: :id
    )

end
