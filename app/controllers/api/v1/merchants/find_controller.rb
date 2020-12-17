class Api::V1::Merchants::FindController < ApplicationController
  def show
    attribute = params.keys.first
    value = params.values.first
    if attribute == 'name'
      render json: MerchantSerializer.new(Merchant.find_by("#{attribute} iLIKE '%#{value}%'"))
    else
      render json: MerchantSerializer.new(Merchant.find_by("#{attribute} = ?", "#{value}"))
    end
  end

  def index
    attribute = params.keys.first
    value = params.values.first
    if attribute == 'name'
      render json: MerchantSerializer.new(Merchant.where("#{attribute} iLIKE '%#{value}%'"))
    else
      render json: MerchantSerializer.new(Merchant.where("#{attribute} = ?", "#{value}"))
    end
  end
end
