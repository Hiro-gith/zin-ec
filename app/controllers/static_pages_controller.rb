class StaticPagesController < ApplicationController
  # 事前にログイン済みユーザーかどうか確認
  before_action :logged_in_user,only: [:histories]
  
  # ルート
  def arazin
    @items = Item.all
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
  
  
  
  
  
  
  
  # 他のポートフォリオ
  def cafe
  end
  
  def gallery
  end
  
  def javascript
  end
  
  
end
