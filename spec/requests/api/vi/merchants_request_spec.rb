require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end

  it 'can create a new merchant' do
    merchant_params = {name: 'Zorg Enterprises'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/merchants', headers: headers, params: JSON.generate(merchant: merchant_params)
    created_merchant = Merchant.last

    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it 'can update an existing merchant' do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: 'Fhloston Cruiselines' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate({ merchant: merchant_params })
    merchant = Merchant.find(id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq('Fhloston Cruiselines')
  end

  # edge
  it 'will only update a single record' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    merchant_1.name = 'Merchant 1'
    merchant_2.name = 'Merchant 2'
    merchant_3.name = 'Merchant 3'

    merchant_2_id = merchant_2.id
    previous_name = merchant_2.name
    merchant_params = { name: 'Fhloston Cruiselines' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/merchants/#{merchant_2_id}", headers: headers, params: JSON.generate({ merchant: merchant_params })
    merchant = Merchant.find(merchant_2_id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq('Fhloston Cruiselines')
    expect(merchant_1.name).to eq("Merchant 1")
    expect(merchant_3.name).to eq("Merchant 3")
  end
end
