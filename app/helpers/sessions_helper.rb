module SessionsHelper

  # session[:user_id]（一時cookies）にuser.idを暗号化して保存する
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 記憶トークンから記憶ダイジェストにしデータベースへ保存
  # 永続的クッキーにユーザーidと記憶トークンを保存
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    # 代入後user_idがtrueなら（session[:user_id]があれば）
    if (user_id = session[:user_id])
      # @current_userがnilなら代入する
      # インスタンス変数に保存することで、データベースへの問い合わせを1回にする
      @current_user ||= User.find_by(id: session[:user_id])
      
    # 代入後user_idがtrueなら（cookies.signed[:user_id]があれば）  
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # session[:forwarding_url]にアクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end