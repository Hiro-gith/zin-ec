class CartsController < ApplicationController
  before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
    @citems = current_cart.citems
  end

  # item/showから、「カートに入れる」を押した時のアクション
  def add_item
    if @citem.blank?
      @citem = current_cart.citems.build(item_id: params[:item_id])
    end
    
    @citem.quantity += params[:quantity].to_i
    @citem.save
    redirect_to current_cart
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
  
  # カート詳細画面から、「購入する」を押した時のアクション
  def cart_login
    session[:item_id] = params[:item_id]
  end

  # カートのログイン画面から「ログイン」を押した時のアクション
  def cart_login_create
    @user = User.find_by(email: params[:session][:email].downcase)
    # 有効なユーザーでかつ正しいパスワードか
    if @user && @user.authenticate(params[:session][:password])
      # ログインする
      log_in @user
      
      # チェックボックスにチェックが入っていればremember(@user)、入っていなければforget(@user)
      # remember(user)は記憶トークンから記憶ダイジェストにしデータベースへ保存
      # さらに永続的クッキーにユーザーidと記憶トークンを保存
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      
      # 記憶したURL (もしくはルートパス) にリダイレクト
      redirect_to pay_view_path
      
    else
      # flash.nowとすると、別のリクエストが来たときに消える
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが無効です。'
      # ログインフォームを再表示
      render 'cart_login'
    end
  end
  
  def pay_view
    @citem = current_cart.citems.find_by(item_id: session[:item_id])
    if @citem.nil?
      flash[:danger] = 'エラーが発生しました。再度やり直しをお願いします'
      redirect_to current_cart
    end
  end
  
  def pay_confirmation
    @bought = Bought.find_by(item_id: session[:item_id])
  end
  
  private

  # 現在のカートからアイテムを特定する
  def setup_cart_item!
    @citem = current_cart.citems.find_by(item_id: params[:item_id])
  end
  
end
