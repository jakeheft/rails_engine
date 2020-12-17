class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices

  def self.most_revenue(quantity)
    Merchant.joins(invoices: %i[transactions invoice_items]).select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue').where('transactions.result = ?', 'success').where('invoices.status = ?', 'shipped').group(:id).order('revenue DESC').limit(quantity)
  end

  def self.most_items_sold(quantity)
    Merchant.joins(invoices: %i[transactions invoice_items]).select('merchants.*, SUM(invoice_items.quantity) AS quantity').where('transactions.result = ?', 'success').group(:id).order('quantity DESC').limit(quantity)
  end
end
