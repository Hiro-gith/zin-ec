class StaticPagesController < ApplicationController
  # 事前にログイン済みユーザーかどうか確認
  before_action :logged_in_user,only: [:histories,:clips,:boughts]
  
  # ルート
  def arazin
    @items = Item.all
    @items_rank_kaden = Item.where(category: "家電").order(sales: "DESC")
    @items_rank_norimono = Item.where(category: "乗り物").order(sales: "DESC")
    @items_rank_food = Item.where(category: "食品").order(sales: "DESC")
    
    if logged_in?
      @user = current_user
    end
  end
  
  def magicdeal
    @items = Item.all
  end
  
  def ranking
  end
  
  def card
  end
  
  def help
  end
  
  def ec
  end
  
  def histories
    @histories = current_user.histories.page (params[:page])
    # @items = @user.items.page (params[:page])
  end
  
  def clips
    @clips = current_user.clips.page (params[:page])
    # @items = @user.items.page (params[:page])
  end
  
  def boughts
    @boughts = current_user.boughts.page (params[:page])
  end
  
  
  
  # 他のポートフォリオ
  def cafe
  end
  
  def gallery
  end
  
  def javascript
  end
  
  
end
