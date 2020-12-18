require 'rails_helper'

describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    before :each do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)

      @item1 = create(:item, merchant: @merchant1)
      @item2 = create(:item, merchant: @merchant2)
      @item3 = create(:item, merchant: @merchant3)

      @inv1 = create(:invoice, merchant: @merchant1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
      @inv2 = create(:invoice, merchant: @merchant2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
      @inv3 = create(:invoice, merchant: @merchant3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')

      @inv_it1 = create(:invoice_item, invoice: @inv1, item: @item1, quantity: 10, unit_price: 10) # rev: $100
      @inv_it2 = create(:invoice_item, invoice: @inv2, item: @item2, quantity: 20, unit_price: 4) # rev: $80
      @inv_it3 = create(:invoice_item, invoice: @inv3, item: @item3, quantity: 30, unit_price: 3) # rev: $90

      @trans1 = create(:transaction, invoice: @inv1, result: 'success')
      @trans2 = create(:transaction, invoice: @inv2, result: 'success')
      @trans3 = create(:transaction, invoice: @inv3, result: 'success')
    end

    it '.most_revenue()' do
      merchants = Merchant.most_revenue(2)

      expect(merchants).to be_an(ActiveRecord::Relation)
      expect(merchants.to_a.count).to eq(2)
      expect(merchants[0][:id]).to eq(@merchant1.id)
      expect(merchants[1][:id]).to eq(@merchant3.id)
      expect(merchants[2]).to eq(nil)
    end

    it '.most_items_sold()' do
      merchants = Merchant.most_items_sold(2)

      expect(merchants).to be_an(ActiveRecord::Relation)
      expect(merchants.to_a.count).to eq(2)
      expect(merchants[0][:id]).to eq(@merchant3.id)
      expect(merchants[1][:id]).to eq(@merchant2.id)
      expect(merchants[2]).to eq(nil)
    end

    it '.revenue()' do
      revenue1 = Merchant.revenue(@merchant1.id)
      revenue2 = Merchant.revenue(@merchant2.id)
      revenue3 = Merchant.revenue(@merchant3.id)

      expect(revenue1[0][:revenue]).to eq(100.0)
      expect(revenue2[0][:revenue]).to eq(80.0)
      expect(revenue3[0][:revenue]).to eq(90.0)
    end
  end
end
