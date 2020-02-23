require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @item = items(:orange)
    @other_user = users(:archer)
  end

  
  # ログイン無しでitemをクリエイトしたとき
  test "should redirect create when not logged in" do
    assert_no_difference 'Item.count' do
      post items_path, params: { item: { name: "name",category:"bb",content: "content",price: 50 }}
    end
    assert_redirected_to login_url
  end

  # ログイン無しでitemをデストロイしたとき
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Item.count' do
      delete item_path(@item)
    end
    assert_redirected_to login_url
  end
end
