class StaticPagesController < ApplicationController
  
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
  
  
  
  
  
  
  
  
  
  # 他のポートフォリオ
  def cafe
  end
  
  def gallery
  end
  
  def javascript
  end
  
  
end
