class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices

  def self.most_revenue

  end

  def self.most_items_sold(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items]).select('merchants.*, SUM(invoice_items.quantity) AS quantity').where('transactions.result = ?', 'success').group(:id).order('quantity DESC').limit(quantity)
  end
end
