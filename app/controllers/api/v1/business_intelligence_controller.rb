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
end
