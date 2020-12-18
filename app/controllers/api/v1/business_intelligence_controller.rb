class Api::V1::BusinessIntelligenceController < ApplicationController
  def most_items_sold
    quantity = params[:quantity]
    merchant_data = Merchant.most_items_sold(quantity)
    if quantity.to_i == 1
      render json: MerchantSerializer.new(merchant_data[0])
    else
      render json: MerchantSerializer.new(merchant_data)
    end
  end

  def most_revenue
    quantity = params[:quantity]
    merchant_data = Merchant.most_revenue(quantity)
    if quantity.to_i == 1
      render json: MerchantSerializer.new(merchant_data[0])
    else
      render json: MerchantSerializer.new(merchant_data)
    end
  end

  def revenue_date_range
    start_time = params[:start]
    end_time = params[:end]
    end_time += 'T23:59:59'
    revenue_data = Invoice.revenue_date_range(start_time, end_time)
    render json: RevenueSerializer.revenue(revenue_data)
  end

  def merchant_revenue
    render json: RevenueSerializer.revenue(Merchant.revenue(params[:id]))
  end
end
