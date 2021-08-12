require 'rails_helper'

RSpec.describe Link do
  context 'Model' do
    it 'is valid if it has an original URL and a short url' do
      link = Link.new(
        original_url: 'https://www.favoritewebsite.com/articles/how-to-cook',
        short_url: 'https://www.favoritewebsite.com/'
      )
      expect(link.valid?).to be(true)
    end

    it 'is invalid if the URL is not formatted properly' do
      link = Link.new(
        original_url: 'asdsdgsdg',
        short_url: 'https://www.favoritewebsite.com/'
      )
      expect(link.valid?).to be(false)
    end

    it 'is invalid if does not have short url' do
      link = Link.new(
        original_url: 'https://www.favoritewebsite.com/articles/how-to-cook'
      )
      expect(link.valid?).to be(false)
    end

    it 'is invalid if does not have original url' do
      link = Link.new(
        short_url: 'https://www.favoritewebsite.com/'
      )
      expect(link.valid?).to be(false)
    end

    it 'is invalid if does not have original url' do
      link = Link.new(
        original_url: 'https://www.favoritewebsite.com/articles/how-to-cook',
        short_url: 'https://www.favoritewebsite.com/'
      )
      link.save

      link2 = Link.new(
        original_url: 'https://www.favoritewebsite.com/articles/how-to-cook',
        short_url: 'https://www.favoritewebsite.com/'
      )

      expect(link2.valid?).to be(false)
    end
  end
end
