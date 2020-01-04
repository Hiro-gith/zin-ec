class SessionsController < ApplicationController

  def new
  end
  
  # login_pathへpost
  # @userにしておくと、仮想なremember_tokenを、テストでassigns(:user).remember_tokenとしてアクセスできる
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # 有効なユーザーでかつ正しいパスワードか
    if @user && @user.authenticate(params[:session][:password])
      # ログインする
      log_in @user
      
      # チェックボックスにチェックが入っていればremember(@user)、入っていなければforget(@user)
      # remember(user)は記憶トークンから記憶ダイジェストにしデータベースへ保存
      # さらに永続的クッキーにユーザーidと記憶トークンを保存
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      
      # ユーザーログイン後にルートにリダイレクトする
      redirect_to root_path
    else
      # flash.nowとすると、別のリクエストが来たときに消える
      flash.now[:danger] = 'Invalid email/password combination'
      
      # ログインフォームを再表示
      render 'new'
    end
  end


  # logout_pathへdestroy
  def destroy
    # 別のウインドウでログアウトする可能性を考慮（2回ログアウト）
    log_out if logged_in?
    redirect_to root_url
  end
end
