class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else 
      items = Item.all
    end
    render json: items, include: :user, status: :ok
  end

  def show 
    items = Item.find(params[:id])
    render json: items, status: :ok
  end

  def create
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items.create(
        name: params[:name], 
        description: params[:description], 
        price: params[:price]
        )
    else 
      items = Item.create(
        name: params[:name], 
        description: params[:description], 
        price: params[:price]
        )
    end
    render json: items, status: :created
  end

  private 

  def render_not_found_response
    render json: { error: "404 not found" }, status: :not_found
  end

end
