# 永続的セッションのテスト
#ログインしたあと、ブラウザを落とす。そのあと永続的クッキーが動作しているか

require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    # チェックボックスにチェックを入れる
    remember(@user)
  end

  #一時セッションがないときに、ログインを維持しているか
  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  # 記憶ダイジェストと記憶トークンを一致させない時
  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end