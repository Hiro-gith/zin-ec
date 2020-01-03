class SessionsController < ApplicationController

  def new
  end
  
  # login_pathへpost
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # 有効なユーザーでかつ正しいパスワードか
    if user && user.authenticate(params[:session][:password])
      # ログインする
      log_in user
      
      # 記憶トークンから記憶ダイジェストにしデータベースへ保存
      # 永続的クッキーにユーザーidと記憶トークンを保存
      remember user
      
      # ユーザーログイン後にルートにリダイレクトする
      redirect_to root_path
    else
      # flash.nowとすると、別のリクエストが来たときに消える
      flash.now[:danger] = 'Invalid email/password combination'
      
      # ログインフォームを再表示
      render 'new'
    end
  end


  # logoutへdestroy
  def destroy
    log_out
    redirect_to root_url
  end
end
