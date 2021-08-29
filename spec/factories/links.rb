FactoryBot.define do
  factory :link do
    short_url { Faker::Internet.url(host: 'localh') }
    original_url { Faker::Internet.url(host: 'www.grammar.cl', path: '/english/how-much-how-many.htm', scheme: 'https://') }
    generate_link_password { Faker::Internet.password(min_length: 8, max_length: 16) }
  end
end
