class UsersController < ApplicationController
  # 事前にログイン済みユーザーかどうか確認
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  
  # 事前に正しいユーザーかどうか確認
  before_action :correct_user,   only: [:edit, :update]
  
  # 事前に管理者かどうか確認
  before_action :admin_user,     only: :destroy
  
  # ユーザー一覧を表示する /users
  def index
    # すべてのユーザーをよびだす
    # paginateのkaminariに渡せる形で渡す
    @users = User.page(params[:page])
  end

  # 会員ページ　/users/:id  user_path(user)
  def show
    @user = User.find(params[:id])
    @items = @user.items.page (params[:page])
    
    # redirect_to root_url and return unless @user.activated 
    
  end
  
  # 新規会員登録　/signup　
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
  
  # 会員編集ページへのアクセス
  def edit
  end
  
  # 会員ページの編集フォームを送信
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "編集内容を保存しました"
      
      # ユーザーshowページへリダイレクト
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  # 管理者権限がある場合、indexページからユーザーを削除する
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  # 外部から操作できない
  private

    # ユーザー新規作成・編集時に許可するパラメータ
    def user_params
      # :user属性を必須とし、その上で各属性を許可する
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # beforeアクション
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
