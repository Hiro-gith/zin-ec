require 'test_helper'

class ClipsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @item = items(:orange)
  end
  
  # ログインせずにcreateアクション(お気に入りに追加)を実行
  test "should redirect create when not logged in" do
    post add_clip_item_path(@item)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  # ログインせずにcreateアクション(お気に入りに追加)を実行
  test "should redirect destroy when not logged in" do
    delete clip_path(@item)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
