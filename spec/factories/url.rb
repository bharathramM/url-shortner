FactoryBot.define do
  factory :url do
    trait :valid do
      source { 'www.google.com' }
    end
  end
end