module SessionsHelper

  # session[:user_id]（一時cookies）にuser.idを暗号化して保存する
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      # @current_userがnilなら代入する
      # インスタンス変数に保存することで、データベースへの問い合わせを1回にする
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end