class Api::V1::Merchants::FindController < ApplicationController
  def show
    attribute = params.keys.first
    value = params.values.first
    render json: MerchantSerializer.new(Merchant.find_by("#{attribute} iLIKE '%#{value}%'"))
  end
end
