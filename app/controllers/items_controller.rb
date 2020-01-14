class ItemsController < ApplicationController
  # 事前にログイン済みユーザーかどうか確認
  before_action :logged_in_user,except: [:index, :show]
  
  # 事前に正しいユーザーかどうか確認
  before_action :correct_user,except: [:index, :show]
  
  #  商品新規登録　itemcreate_pathへget
  def new
  end
  
  def show
  end
  
  # 商品の新規登録
  def create
    @item = current_user.items.new(item_params)
    if @item.save
      flash[:success] = "商品が登録されました！"
      
      # ユーザーshowページへリダイレクト(保留)
      redirect_to @user
    else
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
  end
  
  def item_params
      params.require(:item).permitpermit(:name, :category, :content,:price)
  end
end
