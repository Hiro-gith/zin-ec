require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @item = @user.items.build(name:"aa",category:"bb",content: "Lorem ipsum", price:0,user_id: @user.id)
  end

  # 初期値が正しいか
  test "should be valid" do
    assert @item.valid?
  end
  
  # 名前が空な時
  test "name should be present" do
    @item.name = "   "
    assert_not @item.valid?
  end
  
  # 名前の長さが50字以上なとき
  test "name should be at most 50 characters" do
    @item.name = "a" * 51
    assert_not @item.valid?
  end
  
  # カテゴリーが空な時
  test "category should be present" do
    @item.category = "   "
    assert_not @item.valid?
  end
  
  # コンテントが空な時
  test "content should be present" do
    @item.content = "   "
    assert_not @item.valid?
  end
  
  # コンテントの長さが300字以上なとき
  test "content should be at most 300 characters" do
    @item.content = "a" * 301
    assert_not @item.valid?
  end
  
   # 価格が空な時
  test "price should be present" do
    @item.price = "   "
    assert_not @item.valid?
  end
  
  # 価格が-なとき
  test "price should be more than 0 characters" do
    @item.price = -1
    assert_not @item.valid?
  end
  
  # user_idにnilが入っていた場合（所有者が不明な場合）
  test "user id should be present" do
    @item.user_id = nil
    assert_not @item.valid?
  end
  
  # 最も新しいものが最初にくる
  test "order should be most recent first" do
    assert_equal items(:most_recent), Item.first
  end

  
end
