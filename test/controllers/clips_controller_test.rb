require 'test_helper'

class ClipsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  # ログインせずにcreateアクション(お気に入りに追加)を実行
  test "should redirect create when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
