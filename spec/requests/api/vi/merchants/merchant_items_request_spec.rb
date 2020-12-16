require 'rails_helper'

describe 'Merchant Items API' do
  it 'can get a merchants items' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    item_data = JSON.parse(response.body, symbolize_names: true)
    items = item_data[:data]

    expect(items.count).to eq(5)

    items.each do |item|
      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  # edge
  it 'wont get another merchants items' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)
    merchant_2 = create(:merchant)
    other_merchants_item = create(:item, merchant: merchant_2)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    item_data = JSON.parse(response.body, symbolize_names: true)
    items = item_data[:data]

    items.each do |item|
      expect(item[:attributes][:id]).to_not eq(other_merchants_item.id)
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
    end
  end
end
