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

    context 'when Method' do
      let(:link) { Link.create(short_url: 'localo',
                                original_url: 'localhost/fake_test_path',
                                generate_link_password: '12345678122314',
                                last_date_visit_link: 3.months.ago) }
      let(:destroy_link) { Link.create( short_url: 'localo',
                                original_url: 'localhost/fake_test_path',
                                generate_link_password: '12345678122314') }

      it 'doesnt have last_date_visit_link greater than two months' do
        Link.link_destroy_greater_than_two
        expect(link).not_to be(true)
      end


      it 'doesnt destroy short url' do
        Link.update(short_url: nil)
        expect(destroy_link).not_to be(true)
      end
    end
  end
