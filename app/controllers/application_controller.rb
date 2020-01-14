class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
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
end
