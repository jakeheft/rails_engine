require 'rails_helper'

describe 'Record search' do
  it 'can find a single name' do
    create(:item, name: 'Fire Stone')
    create(:item, name: 'Earth Stone')

    get '/api/v1/items/find?name=stone'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    stone = json[:data][:attributes]
    name = stone[:name].downcase

    expect(name).to include('stone')
    expect(json).to be_a(Hash)
    expect(stone).to be_a(Hash)
  end
end
