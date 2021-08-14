class Link < ApplicationRecord
  validates :short_url, presence: true
  validates :original_url, presence: true, uniqueness: { case_sensitive: false }
  validate :original_url_format

  def original_url_format
    uri = URI.parse(original_url || '')
    if uri.host.nil?
      errors.add(:original_url, 'Invalid URL format')
    end
  end

  def shortened_url
    "http://localhost:3000/#{short_url}"
  end

  def link_destroy_greater_than_two(link)
    link.shortened_url.destroy if link.visit_link_count.Time.prev_month(months = 2)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["short_url", "visit_link_count"]
  end

  private

  # def visit_link(link)
  #   link = @link.shortened_url
  #   if action == 'show'
  #     link.update_attributes(visit_count_link: 1)
  #   else
  #     visit_count_link: 0
  # end
  #   end

end
