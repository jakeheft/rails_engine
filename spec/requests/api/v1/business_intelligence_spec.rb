require 'rails_helper'

describe 'Business intelligence' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @item3 = create(:item, merchant: @merchant3)
    @item4 = create(:item, merchant: @merchant4)
    @item5 = create(:item, merchant: @merchant5)

    @inv1 = create(:invoice, merchant: @merchant1, status: 'shipped', created_at: '2020-01-01T00:00:00 UTC')
    @inv2 = create(:invoice, merchant: @merchant2, status: 'shipped', created_at: '2020-02-02T00:00:00 UTC')
    @inv3 = create(:invoice, merchant: @merchant3, status: 'shipped', created_at: '2020-03-03T00:00:00 UTC')
    @inv4 = create(:invoice, merchant: @merchant4, status: 'shipped', created_at: '2020-04-04T00:01:00 UTC')
    @inv5 = create(:invoice, merchant: @merchant5, status: 'shipped', created_at: '2020-05-05T00:00:00 UTC')
    @inv6 = create(:invoice, merchant: @merchant5, status: 'packaged', created_at: '2020-06-06T00:00:00 UTC')

    @inv_it1 = create(:invoice_item, invoice: @inv1, item: @item1, quantity: 10, unit_price: 10) # rev: $100
    @inv_it2 = create(:invoice_item, invoice: @inv2, item: @item2, quantity: 20, unit_price: 4) # rev: $80
    @inv_it3 = create(:invoice_item, invoice: @inv3, item: @item3, quantity: 30, unit_price: 3) # rev: $90
    @inv_it4 = create(:invoice_item, invoice: @inv4, item: @item4, quantity: 41, unit_price: 2) # rev: $82
    @inv_it5 = create(:invoice_item, invoice: @inv5, item: @item5, quantity: 50, unit_price: 1) # rev: $50
    @inv_it6 = create(:invoice_item, invoice: @inv6, item: @item5, quantity: 100, unit_price: 5) # rev: $500

    @trans1 = create(:transaction, invoice: @inv1, result: 'success')
    @trans2 = create(:transaction, invoice: @inv2, result: 'success')
    @trans3 = create(:transaction, invoice: @inv3, result: 'success')
    @trans4 = create(:transaction, invoice: @inv4, result: 'success')
    @trans5 = create(:transaction, invoice: @inv5, result: 'success')
    @trans6 = create(:transaction, invoice: @inv6, result: 'failed')


  end

  it 'can get single merchant with the most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=1'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes][:name]).to eq(@merchant1.name)
    expect(merchant[:attributes][:id]).to eq(@merchant1.id)
  end

  it 'can get merchants with the most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(merchants).to be_a(Array)
    expect(merchants.count).to eq(3)
    expect(merchants.first[:attributes][:name]).to eq(@merchant1.name)
    expect(merchants.first[:attributes][:id]).to eq(@merchant1.id)
  end

  it 'can get single merchant with the most items sold' do
    get '/api/v1/merchants/most_items?quantity=1'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant = json[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes][:name]).to eq(@merchant5.name)
    expect(merchant[:attributes][:id]).to eq(@merchant5.id)
  end

  it 'can get merchants with the most items sold' do
    get '/api/v1/merchants/most_items?quantity=3'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    expect(merchants).to be_an(Array)
    expect(merchants.count).to eq(3)
    expect(merchants.first[:attributes][:name]).to eq(@merchant5.name)
    expect(merchants.first[:attributes][:id]).to eq(@merchant5.id)
  end

  it 'can get revenue across a date range' do
    get '/api/v1/revenue?start=2020-03-01&end=2020-05-01'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    revenue = json[:data][:attributes][:revenue]

    expect(revenue).to be_a(Float)
    expect(revenue).to eq(172.0)
  end

  # edge
  it 'can get revenue across a date range including invoices on end date' do
    get '/api/v1/revenue?start=2020-03-01&end=2020-04-04'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    revenue = json[:data][:attributes][:revenue]

    expect(revenue).to be_a(Float)
    expect(revenue).to eq(172.0)
  end
end
