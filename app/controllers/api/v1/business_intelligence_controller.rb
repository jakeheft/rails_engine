class Api::V1::BusinessIntelligenceController < ApplicationController
  def most_items_sold
    quantity = params[:quantity]
    if quantity.to_i == 1
      merchant = MerchantFacade.most_items_sold(quantity)
      render json: MerchantSerializer.new(merchant[0])
    else
      merchants = MerchantFacade.most_items_sold(quantity)
      render json: MerchantSerializer.new(merchants)
    end
  end
end
