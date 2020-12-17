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

  it 'can find a single item by created_at' do
    item_1 = create(:item, created_at: '2020-11-16T00:00:00 UTC')
    item_2 = create(:item, created_at: '2020-12-16T00:00:00 UTC')

    get '/api/v1/items/find?created_at=2020-12-16T00:00:00 UTC'

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data][:attributes]
    created_at = item[:created_at]
    
    expect(item).to be_a(Hash)
    expect(item[:id]).to eq(item_2.id)
    expect(created_at).to include('12')
  end

  it 'can find multiple items by name' do
    create(:item, name: 'Fire Stone')
    create(:item, name: 'Earth Stone')
    create(:item, name: 'Chicken')

    get '/api/v1/items/find_all?name=stone'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    stones = json[:data]

    expect(stones).to be_an(Array)
    expect(stones.count).to eq(2)
    stones.each do |stone|
      expect(stone[:attributes][:name].downcase).to include('stone')
      expect(stone[:attributes][:name].downcase).to_not include('chicken')
      expect(stone).to be_a(Hash)
    end
  end
end
