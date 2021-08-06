require 'digest/sha2'

class Linkened

  attr_reader :url, :link_model

  def initialize(url, link_model = Link)
    @url = url
    @link_model = link_model
  end

  def generate_short_link
    link_model.create(original_url: url, short_url: short_url)
  end

  def short_url
    loop do
      code = get_fresh_code
      break code unless link_model.exists?(short_url: code)
    end
  end

  private

  def get_fresh_code
    SecureRandom.uuid[0..6]
  end
end
