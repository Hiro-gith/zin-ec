require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  # ログイン時に無効な情報を入力
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
   # ログイン時に有効な情報を入力
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'passwordpass' } }
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/arazin'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", root_path
    
    # ログアウトする
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", root_path
  end
  
  # チェックボックスにチェックが入っているとき、記憶トークンがあるか
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    
    assert_equal cookies['remember_token'] , assigns(:user).remember_token
  end

  # チェックボックスにチェックが入っているとき、ログアウトで記憶トークンを消せているか
  # チェックボックスにチェックが入っていないとき、記憶トークンがないか
  test "login without remembering" do
    # クッキーを保存してログイン
    log_in_as(@user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end