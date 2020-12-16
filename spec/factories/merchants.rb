FactoryBot.define do
  factory :merchant do
    name { Faker::TvShows::SiliconValley.company }

    # trait :with_items do
    #   after :create do |merchant|
    #     create_list(:item, 2, merchant: merchant)
    #   end
    # end
  end
end
