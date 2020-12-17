class Api::V1::Items::FindController < ApplicationController
  def show
    attribute = params.keys.first
    value = params.values.first
    if attribute == 'name' || attribute == 'description'
      render json: ItemSerializer.new(Item.find_by("#{attribute} iLIKE '%#{value}%'"))
    else
      render json: ItemSerializer.new(Item.find_by("#{attribute} = ?", "#{value}"))
    end
  end

  def index
    attribute = params.keys.first
    value = params.values.first
    if attribute == 'name' || attribute == 'description'
      render json: ItemSerializer.new(Item.where("#{attribute} iLIKE '%#{value}%'"))
    else
      render json: ItemSerializer.new(Item.where("#{attribute} = ?", "'%#{value}%'"))
    end
  end
end
