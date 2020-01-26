class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :set_search
  
  # 検索用（ransack）
    def set_search
      @q        = Item.ransack(params[:q])
      @items = @q.result.page(params[:page]).per(20)
    end
    
  private

    # ログイン済みユーザーかどうか確認
    # ログインしていなかったらログイン画面へリダイレクト
    def logged_in_user
      unless logged_in?
        # session[:forwarding_url]にアクセスしようとしたURLを覚えておく
        store_location
        
        flash[:danger] = "ログインが必要です"
        redirect_to login_url
      end
    end
    
     # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 検索用ストロングパラメータ
    def search_params
      params.require(:q).permit(:name_or_content_cont)
    end
end
