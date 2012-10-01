class OrderTypesController < ApplicationController
  before_filter  :require_admin

  make_resourceful do
    actions :all
  end

  def edit
    @order_type=OrderType.find(params[:id])
    render :layout=>false
  end
end

