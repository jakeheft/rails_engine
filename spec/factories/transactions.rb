results = ['failed', 'success', 'refunded']
5.times { results << 'failed' }
50.times { results << 'success' }
FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.within(range: 4000_0000_0000_0000..4999_9999_9999_9999) }
    credit_card_expiration_date { '04/23' }
    result { results.sample }
    invoice
  end
end
