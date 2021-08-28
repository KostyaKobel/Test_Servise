FactoryBot.define do
  factory :link do
    short_url { Faker::Internet.url(host: 'localh') }
    original_url { Faker::Internet.url(host: 'localhost', path: '/fake_test_path', scheme: 'https') }
    generate_link_password { Faker::Internet.password(min_length: 8, max_length: 16) }
    last_date_visit_link { 3.months.ago }
  end
end
