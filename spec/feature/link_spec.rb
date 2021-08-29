require 'rails_helper'

RSpec.describe 'Showing', type: :feature do
  let(:test_link) { FactoryBot.create(:link) }

  describe('list of places') do
    before do
      visit links_path
    end

    context 'when it has' do
      it 'headers\'s title' do
        expect(page).to have_content('Signed in as user')
      end
    end

    context 'with redirects to' do
      it 'home page' do
        click_on 'Main', match: :first
        have_current_path eq(root_path)
      end

      it 'New Original page' do
        click_on 'New Original link', match: :first
        have_current_path eq(new_link_path)
      end

      it 'Admin Links page' do
        click_on 'Admin Links', match: :first
        have_current_path eq(admin_links_path)
      end
    end

    context 'when it has' do
      it 'headers\'s title' do
        visit new_link_path
        expect(page).to have_content('Original URL')
      end

      it 'headers\'s title' do
        visit edit_link_path(test_link)
        expect(page).to have_content('Original URL')
      end
    end
  end
end
