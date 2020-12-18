require 'rails_helper'

describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
  end

  describe 'class methods' do
    it '.revenue_date_range()' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)

      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      item3 = create(:item, merchant: merchant3)

      inv1 = create(:invoice, merchant: merchant1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
      inv2 = create(:invoice, merchant: merchant2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
      inv3 = create(:invoice, merchant: merchant3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')

      inv_it1 = create(:invoice_item, invoice: inv1, item: item1, quantity: 10, unit_price: 10) # rev: $100
      inv_it2 = create(:invoice_item, invoice: inv2, item: item2, quantity: 20, unit_price: 4) # rev: $80
      inv_it3 = create(:invoice_item, invoice: inv3, item: item3, quantity: 30, unit_price: 3) # rev: $90

      trans1 = create(:transaction, invoice: inv1, result: 'success')
      trans2 = create(:transaction, invoice: inv2, result: 'success')
      trans3 = create(:transaction, invoice: inv3, result: 'success')

      revenue = Invoice.revenue_date_range('2020-02-01', '2020-04-01')

      expect(revenue).to be_an(ActiveRecord::Relation)
      expect(revenue[0][:revenue]).to be_a(Float)
      expect(revenue[0][:revenue]).to eq(170.0)
    end
  end
end
