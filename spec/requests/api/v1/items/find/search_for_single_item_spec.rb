require 'rails_helper'

describe 'Record search' do
  it 'can find a single item by name' do
    create(:item, name: 'Fire Stone')
    create(:item, name: 'Earth Stone')

    get '/api/v1/items/find?name=stone'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    stone = json[:data][:attributes]
    name = stone[:name].downcase

    expect(name).to include('stone')
    expect(name).to_not include('earth')
    expect(json).to be_a(Hash)
    expect(stone).to be_a(Hash)
  end

  it 'can find a single item by description' do
    create(:item, description: 'Some Item')
    create(:item, description: 'Another Item')

    get '/api/v1/items/find?description=item'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data][:attributes]
    description = item[:description].downcase

    expect(description).to include('item')
    expect(description).to_not include('another')
  end

  it 'can find a single item by description' do
    create(:item)
    create(:item)

    get '/api/v1/items/find?created_at=16'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data][:attributes]
    created_at = item[:created_at].downcase
require "pry"; binding.pry
    expect(created_at).to include('item')
    expect(created_at).to_not include('another')
  end
end
