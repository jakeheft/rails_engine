require 'rails_helper'

 describe 'Merchant Record Search' do
   it 'can find a single merchant by name' do
    merchant1 = create(:merchant, name: 'Zorg Industries')
    merchant2 = create(:merchant, name: 'Fhloston Cruiselines')
    merchant3 = create(:merchant, name: 'Mangalorian Industries')

    get '/api/v1/merchants/find?name=indust'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant_data = json[:data]
    name = merchant_data[:attributes][:name].downcase

    expect(merchant_data).to be_a(Hash)
    expect(merchant_data[:attributes][:id]).to eq(merchant1.id)
    expect(merchant_data[:attributes][:name]).to eq(merchant1.name)
    expect(name).to include('indust')
    expect(name).to_not include('mangalorian')
   end

   it 'can find a single merchant by date' do
    merchant1 = create(:merchant, created_at: '2020-10-16T00:00:00 UTC')
    merchant2 = create(:merchant, created_at: '2020-11-16T00:00:00 UTC')
    merchant3 = create(:merchant, created_at: '2020-12-16T00:00:00 UTC')

    get '/api/v1/merchants/find?created_at=2020-10-16T00:00:00 UTC'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant_data = json[:data]
    found_merchant = Merchant.find(merchant_data[:id])

    expect(merchant_data).to be_a(Hash)
    expect(merchant_data[:attributes][:id]).to eq(merchant1.id)
    expect(merchant_data[:attributes][:name]).to eq(merchant1.name)
    expect(found_merchant).to eq(merchant1)
   end

   it 'can find merchants by name' do
    merchant1 = create(:merchant, name: 'Zorg Industries')
    merchant2 = create(:merchant, name: 'Fhloston Cruiselines')
    merchant3 = create(:merchant, name: 'Mangalorian Industries')

    get '/api/v1/merchants/find_all?name=indust'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant_data = json[:data]

    expect(merchant_data).to be_an(Array)
    expect(merchant_data.count).to eq(2)
    merchant_data.each do |merchant|
      expect(merchant[:attributes][:id]).to_not eq(merchant2.id)
      expect(merchant[:attributes][:name].downcase).to include('indust')
    end
   end

   it 'can find merchants by date' do
    merchant1 = create(:merchant, name: 'm1', updated_at: '2020-12-14T00:00:00 UTC')
    merchant2 = create(:merchant, name: 'm2', updated_at: '2020-12-15T00:00:00 UTC')
    merchant3 = create(:merchant, name: 'm3', updated_at: '2020-12-15T00:00:00 UTC')

    get '/api/v1/merchants/find_all?updated_at=2020-12-15T00:00:00 UTC'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchant_data = json[:data]

    expect(merchant_data).to be_an(Array)
    expect(merchant_data.count).to eq(2)
    merchant_data.each do |merchant|
      found_merchant = Merchant.find(merchant[:id])
      expect(merchant[:attributes][:id]).to_not eq(merchant1.id)
      expect(found_merchant).to be_a(Merchant)
      expect(found_merchant).to_not eq(merchant1)
    end
    expect(merchant_data.first[:id].to_i).to eq(merchant2.id)
    expect(merchant_data.last[:id].to_i).to eq(merchant3.id)
   end
 end
