require 'rails_helper'

RSpec.describe "Links", type: :request do

  it 'redirects to the original URL for a given short link' do
    url = 'https://getbootstrap.com/docs/5.0/components/buttons/'
    linkened = Linkened.new(url)
    link = linkened.generate_short_link
    get link.shortened_url
    expect(response).to redirect_to(link.original_url)
  end
end
