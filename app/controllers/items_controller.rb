class ItemsController < ApplicationController
  # 事前にログイン済みユーザーかどうか確認
  before_action :logged_in_user,except: [:index,:show]
  
  # 他のユーザーの操作を受け付けない
  # newとcreateはビュー側で表示させない
  before_action :correct_user_item,except: [:new,:create,:index,:show,:destroy]
  
  # 商品新規登録　
  def new
    # 入力フォームの送り先を@itemとし、定義する
    @item = current_user.items.build if logged_in?
  end
  
  # 商品の新規登録 @itemへpostしたとき
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "商品が登録されました！"
      
      # ユーザーshowページへリダイレクト(保留)
      redirect_to current_user
    else
      # 再度表示
      render 'items/new'
    end
  end
  
  def edit
    @item = current_user.items.find_by(id: params[:item_id])
  end
  
  def update
    if @item.update_attributes(item_params)
      flash[:success] = "編集内容を保存しました"
      
      # ユーザーshowページへリダイレクト
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    @item = current_user.items.find_by(id: params[:item_id])
    @item.destroy
    flash[:success] = "商品が削除されました"
    
    redirect_to current_user
  end
  
  # 検索された商品
  def index
    # @q = Item.ransack(params[:q])
    # @Items = @q.result(distinct: true)
  end
  
  # 商品紹介ページ
   def show
    @item = Item.find(params[:id])
   end
  
  # 外部から操作できない
  private
  
    def item_params
        params.require(:item).permit(:name, :category, :content,:price,:picture)
    end
    
    def correct_user_item
      @item = current_user.items.find_by(id: params[:id])
      redirect_to root_url if @item.nil?
    end
end
