require 'test_helper'

class ItemEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  # プロフィールの変更に失敗した時
  test "unsuccessful edit item" do
    get user_path(@user)
    assert_template 'users/show'
    
  end
end
