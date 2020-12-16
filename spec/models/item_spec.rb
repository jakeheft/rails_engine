require 'rails_helper'

describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
  end
end

# describe 'items' do
#   it 'can run faker' do
#     merchants = create_list(:merchant, 3)
#     items = create_list(:item, 30)
#     invoice_items = create_list(:invoice_item, 3)
#     customers = create_list(:customer, 3)
#     invoices = create_list(:invoice, 3)
#     transactions = create_list(:transaction, 30)
#   end
# end
