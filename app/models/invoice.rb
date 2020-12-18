class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions

  def self.revenue_date_range(start_date, end_date)
    query = Invoice.joins(:transactions, :invoice_items)
    .select('SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .where('transactions.result = ?', 'success')
    .where('invoices.status = ?', 'shipped')
    .where('invoices.created_at >= ?', "#{start_date}")
    .where('invoices.created_at <= ?', "#{end_date}")
  end
end
