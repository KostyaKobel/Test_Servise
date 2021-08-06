require 'rails_helper'

RSpec.describe Linkened do

  it 'shortens a given to a 7 character lookup code' do
    url = 'https://www.favoritewebsite.com/articles/how-to-cook'
    linkened = Linkened.new(url)
    expect(linkened.short_url.length).to eq(7)
  end

  it 'gives each URL its own lookup code' do
    url = 'https://www.favoritewebsite.com/articles/how-to-cook'
    linkened = Linkened.new(url)
    link_1 = linkened.short_url

    url = 'https://www.favoritewebsite.com/articles/how-to-bake'
    linkened = Linkened.new(url)
    link_2 = linkened.short_url

    expect(link_2).not_to eq(link_1)
  end

  it 'generates a Link record with a unique short_url' do
    url = 'https://www.favoritewebsite.com/articles/how-to-cook'
    linkened = Linkened.new(url)
    link = linkened.generate_short_link
    expect(link.valid?).to be(true)

    link2 = linkened.generate_short_link
    expect(link2.valid?).to be(true)
  end

end
