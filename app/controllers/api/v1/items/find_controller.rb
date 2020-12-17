class Api::V1::Items::FindController < ApplicationController
  def show
    attribute = params.keys.first
    value = params.values.first
    if attribute == 'created_at' || attribute == 'updated_at'
      render json: ItemSerializer.new(Item.find_by("#{attribute} = ?", "#{value}"))
    else
      render json: ItemSerializer.new(Item.find_by("#{attribute} iLIKE '%#{value}%'"))
    end
  end

  def index
    attribute = params.keys.first
    value = params.values.first
    render json: ItemSerializer.new(Item.where("#{attribute} iLIKE '%#{value}%'"))
  end
end
