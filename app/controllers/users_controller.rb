class UsersController < ApplicationController
  
  # 特定のユーザーを表示する　/users/:id  user_path(user)
  def show
    @user = User.find(params[:id])
  end
  
  # /signup
  def new
    @user = User.new
  end
  
  # signupページのformに入力された内容をpostしたとき
  def create
    # Strong Parametersを使ってデータを受け取る
    @user = User.new(user_params)
    if @user.save
      # log_inメソッドで一時cookiesにuser.idを暗号化して保存する
      log_in @user
      
      # フラッシュメッセージ
      flash[:success] = "Welcome to the Sample App!"
      
      # ルートへリダイレクト(後で、成功画面を作成して、リダイレクト先を変える)
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  # 外部から操作できない
  private

    def user_params
      # :user属性を必須とし、その上で各属性を許可する
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
