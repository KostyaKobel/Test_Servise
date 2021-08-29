require 'rails_helper'

RSpec.describe "Links", type: :request do

  context 'when valid path' do
    let(:test_link) { FactoryBot.create(:link) }

    it 'returns Index http success' do
      get links_path
      expect(response).to have_http_status(:success)
    end

    it 'returns New http success' do
      get new_link_path
      expect(response).to have_http_status(:success)
    end

    it 'return Show http success' do
      get link_path(test_link)
      expect(response).to redirect_to(test_link.original_url)
    end

    it 'return Edit http success' do
      get edit_link_path(test_link)
      expect(response).to have_http_status(:success)
    end

    it 'return New render partial' do
      get new_link_path
      expect(response).to render_template('links/_link_form')
    end

    it 'return Edit render partial' do
      get edit_link_path(test_link)
      expect(response).to render_template('links/_link_form')
    end

    it "create a Link and redirects to Original page" do
      url = 'https://www.youtube.com/watch?v=4ABesTeDKmQ'
      post links_path, params: { link: { original_url: url } }
      link = assigns(:link)
      expect(response).to be_redirect
      link.generate_short_url
      link.register_visit
      follow_redirect!
      expect(response).to redirect_to(link.original_url)
    end

    it "updates a Link and redirects to Links page" do
      patch link_path(test_link), params: { link: { original_url: 'https://www.youtube.com/watch?v=4ABesTeDKmQ' } }
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to render_template('links/index')
      expect(response.body).to include('Your Link success updated')
    end
  end

end
