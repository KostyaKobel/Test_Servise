class Link < ApplicationRecord
  # validates_presence_of :original_url
  # validates :original_url, format: URI::regexp(%w[http https])
  # validates_uniqueness_of :short_url
  # validates_length_of :original_url, within: 3..255, on: :create, message: "too long"
  # validates_length_of :short_url, within: 3..255, on: :create, message: "too long"
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

  def link_destroy_greater_than_two(*links)
    binding.pry
    links.each do |link|
      months = 2678400
      if Date.parse(link.last_date_visit_link) > 2.months then
        link.short_url.destroy
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["short_url", "visit_link_count"]
  end

  # # auto slug generation
  # before_validation :generate_short_url
  #
  # def generate_short_url
  #   self.short_url = SecureRandom.uuid[0..5] if self.short_url.nil? || self.short_url.empty?
  #   true
  # end
  #
  # # fast access to the shortened link
  # def short
  #   Rails.application.routes.url_helpers.short_url(short_url: self.short_url)
  # end
  #
  # # the API
  # def self.shorten(original_url, short_url = '')
  #   link = Link.where(original_url: original_url, short_url: short_url).first
  #   return link.short if link
  #
  #   link = Link.new(original_url: original_url, short_url: short_url)
  #   return link.short if link.save
  #
  #   Link.shorten(original_url, short_url + SecureRandom.uuid[0..2])
  # end


end
