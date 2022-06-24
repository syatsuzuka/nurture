FactoryBot.define do

  factory :post do
    association :user
    title { Faker::Lorem.sentence(word_count: 5) }
    content { Faker::Lorem.paragraph(sentence_count: 5) }
  end

end
