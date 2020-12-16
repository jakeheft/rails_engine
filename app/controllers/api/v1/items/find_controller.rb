class Api::V1::Items::FindController < ApplicationController
  def show
    attribute = params.keys.first
    value = params.values.first
    render json: ItemSerializer.new(Item.where("#{attribute} iLIKE '%#{value}%'").first)
  end
end
