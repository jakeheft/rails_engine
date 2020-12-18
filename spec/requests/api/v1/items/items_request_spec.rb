require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    item_data = JSON.parse(response.body, symbolize_names: true)
    items = item_data[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
    end
  end

  it 'can get a single item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item_data = JSON.parse(response.body, symbolize_names: true)
    item = item_data[:data][:attributes]

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)

    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to be_an(Integer)
  end

  it 'can create a new item' do
    merchant = create(:merchant)

    item_params = ({
      name: 'Multipass',
      description: 'Mool-tee-pass',
      unit_price: 99.99,
      merchant_id: merchant.id
    })

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/items', headers: headers, params: JSON.generate(item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an existing item' do
    id = create(:item).id

    previous_name = Item.last.name
    item_params = { name: 'Zorg ZF-1' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find(id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
  end

  it 'will only update a single record' do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    item_1.name = 'Item 1'
    item_2.name = 'Item 2'
    item_3.name = 'Item 3'

    item_2_id = item_2.id
    previous_name = item_2.name
    item_params = { name: 'Meat Popsicle' }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v1/items/#{item_2_id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find(item_2_id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq('Meat Popsicle')
    expect(item_1.name).to eq("Item 1")
    expect(item_3.name).to eq("Item 3")
  end

  it 'can destroy an item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    response = delete "/api/v1/items/#{item.id}"

    expect(response).to eq(204)
    expect(Item.count).to eq(0)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
