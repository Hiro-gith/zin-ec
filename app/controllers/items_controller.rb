class ItemsController < ApplicationController
  # 事前にログイン済みユーザーかどうか確認
  before_action :logged_in_user,except: [:index, :show]
  
  # 事前に正しいユーザーかどうか確認
  before_action :correct_user,except: [:index, :show]
  
  # 商品新規登録　itemcreate_pathへget
  def new
    # 入力フォームの送り先を@itemとし、定義する
    @item = current_user.items.build if logged_in?
  end
  
  def show
    @user = User.find(params[:id])
    @items = @user.items.page(params[:page])
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
  end
  
  def update
  end

  def destroy
  end
  
  def index
    # render 'static_pages/arazin'
    @q = Item.ransack(params[:q])
    @Items = @q.result(distinct: true)
  end
  
  def item_params
      params.require(:item).permit(:name, :category, :content,:price)
  end
end
