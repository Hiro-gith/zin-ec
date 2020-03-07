require 'test_helper'

class ClipsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @item = items(:orange)
  end
  
  # お気に入り登録が成功したとき
  test "create clip was success" do
    log_in_as(@user)
    # お気に入り登録をしたとき
    assert_difference 'Clip.count', 1 do
      post add_clip_item_path(@item)
    end
    
    # 重複なお気に入り登録はされない
    assert_no_difference 'User.count' do
      post add_clip_item_path(@item)
    end
    
  end
  
end
