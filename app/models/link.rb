class Link < ApplicationRecord
  validates_presence_of :original_url
  validates :original_url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :original_url
  validates_uniqueness_of :short_url
  validates_length_of :original_url, within: 3..255, on: :create, message: "too long"
  validates_length_of :short_url, within: 3..255, on: :create, message: "too long"

  def shortened_url
    "http://localhost:3000/#{short_url}"
  end

  def self.link_destroy_greater_than_two
    Link.where('last_date_visit_link < ?', 2.months.ago).delete_all
  end

  def self.ransackable_attributes(auth_object = nil)
    ["short_url", "visit_link_count"]
  end

  def register_visit
    update(visit_link_count: visit_link_count + 1, last_date_visit_link: Time.now)
  end

  # auto short_url generation
  before_validation :generate_short_url

  def generate_short_url
    self.short_url = SecureRandom.uuid[0..5] if self.short_url.nil? || self.short_url.empty?
    true
  end

  def generate_link_password
    update(generate_link_password: SecureRandom.uuid[0..15])
  end

  # fast access to the shortened link
  def short
    Rails.application.routes.url_helpers.short_url(short_url: self.short_url)
  end

  # the API
  def self.shorten(original_url, short_url = '')
    link = Link.where(original_url: original_url, short_url: short_url).first
    return link.short if link

    link = Link.new(original_url: original_url, short_url: short_url)
    return link.short if link.save

    Link.shorten(original_url, short_url + SecureRandom.uuid[0..2])
  end

  end
