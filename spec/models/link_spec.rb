require 'rails_helper'

  RSpec.describe Link do
    context 'when valid' do

      let(:test_link) { FactoryBot.create(:link) }
      it 'create link' do
         expect(test_link).to be_valid
      end
    end

    context 'when not valid' do
      let(:test_link) { FactoryBot.build(:link) }
      it 'creates an default short_link' do
        test_link.short_url = 'ht'
        expect(test_link).not_to be_valid
      end

      it 'creates an default short long link' do
        test_link.short_url = 'a' * 256
        expect(test_link).not_to be_valid
      end

      it 'creates an default original_link' do
        test_link.original_url = 'xc'
        expect(test_link).not_to be_valid
      end

      it 'creates an default long original_link' do
        test_link.original_url = 'x' * 256
        expect(test_link).not_to be_valid
      end

      it 'add invalid shortened_url' do
        test_link.short_url = ' '
        expect(test_link).not_to be_valid
      end
    end

    # context 'when Method' do
    #   let(:link) { Link.create(:link) }
    #   it 'should destroy links which greater than two months' do
    #     Link.link_destroy_greater_than_two.should delete_all(:link)
    #   end
    #
    # end
  end
# RSpec.describe Link do
#   context 'Model' do
#     it 'is valid if it has an original URL and a short url' do
#       link = Link.new(
#         original_url: 'https://www.favoritewebsite.com/articles/how-to-cook',
#         short_url: 'https://www.favoritewebsite.com/'
#       )
#       expect(link.valid?).to be(true)
#     end
#
#     it 'is invalid if the URL is not formatted properly' do
#       link = Link.new(
#         original_url: 'asdsdgsdg',
#         short_url: 'https://www.favoritewebsite.com/'
#       )
#       expect(link.valid?).to be(false)
#     end
#
#     it 'is invalid if does not have short url' do
#       link = Link.new(
#         original_url: 'https://www.favoritewebsite.com/articles/how-to-cook'
#       )
#       expect(link.valid?).to be(false)
#     end
#
#     it 'is invalid if does not have original url' do
#       link = Link.new(
#         short_url: 'https://www.favoritewebsite.com/'
#       )
#       expect(link.valid?).to be(false)
#     end
#
#     it 'is invalid if does not have original url' do
#       link = Link.new(
#         original_url: 'https://www.favoritewebsite.com/articles/how-to-cook',
#         short_url: 'https://www.favoritewebsite.com/'
#       )
#       link.save
#
#       link2 = Link.new(
#         original_url: 'https://www.favoritewebsite.com/articles/how-to-cook',
#         short_url: 'https://www.favoritewebsite.com/'
#       )
#
#       expect(link2.valid?).to be(false)
#     end
#   end
# end
