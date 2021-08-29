require 'rails_helper'

RSpec.describe LinksController do
  context 'when Action get' do
    it 'can shorten a link provided by a user' do
      url = 'https://www.favoritewebsite.com/articles/how-to-cook'
      post :create, params: { link: { original_url: url } }
      link = assigns(:link)
      expect(link.original_url).to eq(url)
      expect(link.valid?).to be(true)
      expect(link.short_url.length).to eq(6)
      expect(link.persisted?).to be(true)
      expect(response).to redirect_to(link_path(link))
    end

    # it 'can show to original_url and update visit_link_count' do
    #   url = 'https://www.youtube.com/watch?v=4ABesTeDKmQ'
    #   post :create, params: { link: { original_url: url } }
    #   link = assigns(:link)
    #   link.generate_short_url
    #   link.register_visit
    #   get link.shortened_url
    #   expect(response).to redirect_to(link.original_url)
    # end

    let(:test_link) { FactoryBot.create(:link) }
    it 'can update original_url' do
      link_update = test_link.update(original_url: test_link.original_url + '/')
      expect(link_update).to be(true)
    end
  end
end
# it 'redirects to the original URL for a given short link' do
#     url = 'https://getbootstrap.com/docs/5.0/components/buttons/'
#     linkened = Linkened.new(url)
#     link = linkened.generate_short_link
#     get link.shortened_url
#     expect(response).to redirect_to(link.original_url)
#   end
