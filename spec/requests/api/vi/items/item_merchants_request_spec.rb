require 'rails_helper'

describe 'Item Merchant API' do
  it 'can see an items merchant' do
    og_merchant = create(:merchant)
    item = create(:item, merchant: og_merchant)

    get "/api/v1/items/#{item.id}/merchants"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant_data[:data][:attributes]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(Integer)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end
end
