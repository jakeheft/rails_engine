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
 end
