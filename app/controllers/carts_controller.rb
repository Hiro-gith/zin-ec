class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
    @citems = current_cart.citems

  end

  # 商品一覧画面から、「カートに入れる」を押した時のアクション
  def add_item
    if @citem.blank?
      @citem = current_cart.citems.build(item_id: params[:item_id])
    end
    
    @citem.quantity += params[:quantity].to_i
    @citem.save
    redirect_to current_cart
      # redirect_to 'show'
  end
  
  # カート詳細画面から、「更新」を押した時のアクション
  def update_item
    @citem.update(quantity: params[:quantity].to_i)
    redirect_to current_cart
  end

 # カート詳細画面から、「削除」を押した時のアクション
  def delete_item
    @citem.destroy
    redirect_to current_cart
  end

  private

  # 現在のカートからアイテムを特定する
  def setup_cart_item!
    @citem = current_cart.citems.find_by(item_id: params[:item_id])
  end
end
