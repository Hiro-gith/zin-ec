require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  # プロフィールページ
  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_match @user.name,response.body
    assert_match @user.items.count.to_s, response.body
    assert_match @user.following.count.to_s, response.body  
    assert_match @user.followers.count.to_s, response.body  
    assert_select 'span.item-pagination'

    @user.items.page(1).each do |item|
      assert_match item.content, response.body
    end
  end
end
