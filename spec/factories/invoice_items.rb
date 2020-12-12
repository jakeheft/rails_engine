FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { Faker::Number.within(range: 1..16) }
    unit_price { item.unit_price }
  end
end
