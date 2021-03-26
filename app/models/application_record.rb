class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Takes a user and a long_url as inputs, then creates a shortened_url, which it then adds to the submitter's list of urls.

  def shorten_url(submitter, long_url)
      shortened_url = ShortenedUrl.create!(long_url: long_url, short_url: ShortenedUrl.random_code(long_url))
      submitter.submitted_urls << shortened_url
  end

end
