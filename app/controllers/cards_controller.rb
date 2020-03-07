class CardsController < ApplicationController
  require 'payjp'
  Payjp.api_key = "sk_test_3cd8e8de7da543fb9f0d51af"
  
  def new
     @citem = current_cart.citems.find_by(item_id: session[:item_id])
     if @citem.nil?
       flash[:danger] = 'エラーが発生しました。再度やり直しをお願いします'
       redirect_to current_cart
     end
  end
  
  def create
    @citem = current_cart.citems.find_by(item_id: session[:item_id])
    if @citem.nil?
      flash[:danger] = 'エラーが発生しました。再度やり直しをお願いします'
      redirect_to current_cart and return
    end
    
    # トークンを作成 
    begin
      token = Payjp::Token.create({
      card: {
        number:     params['number'],
        cvc:        params['cvc'],
        exp_month:  params['valid_month'],
        exp_year:   params['valid_year']
      }},
      {'X-Payjp-Direct-Token-Generate': 'true'} 
    )
    rescue Payjp::PayjpError 
      flash[:danger] = '無効なデータが入力されました。再度入力をお願いします'
      redirect_to card_create_path and return
    end

    card = Card.new(card_id: token.id)

    # 上記で作成したトークンをもとに決済する

    @item = Item.find_by(id: @citem.item_id)
    
    @item.sales += params[:quantity].to_i
    @item.save
    
    @user_id = current_user.id
    @item_id = @citem.item_id
    @bought = Bought.new(item_id: @item_id, user_id: @user_id,quantity: params[:quantity].to_i )
    @bought.save
    
    @user = current_user
    @user.points+= params[:points].to_i
    @user.save
    
    @citem.destroy
    
    # 上記で作成したトークンをもとに決済する
    Payjp::Charge.create(currency: 'jpy', amount: params[:amount], card: card.card_id)
    
    redirect_to pay_confirmation_path
    
  end

end