require 'test_helper'

class ItemNewTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
  
  # 有効な商品出品の情報を送信したとき
  test "valid new_item information" do
    get user_path(@user)
    assert_template 'users/show'
    get new_item_path
    assert_difference 'Item.count', 1 do
      post items_path, params: { item: { name:  "りんご",
                                         category: "食品",
                                         content:   "おいしいりんご",
                                         price: 50 ,
                                         score: 0,
                                         posts: 0,
                                         user: "michael"
      } }
    end
    # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動する
    follow_redirect!
    
    assert_template 'users/show'
    
    # フラッシュメッセージが空ではないか
    assert_not flash.empty?
    
  end
  
  #　無効な商品出品の情報を送信したとき(金額)
  test "invalid new_item information" do
  get user_path(@user)
    assert_template 'users/show'
    get new_item_path
    assert_no_difference 'Item.count' do
      post items_path, params: { item: { name:  "りんご",
                                         category: "食品",
                                         content:   "おいしいりんご",
                                         price: -100 ,
                                         score: 0,
                                         posts: 0,
                                         user: "michael"
      } }
    end
    
    assert_template 'items/new'
    
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
    
    assert_select 'form[action="/items"]'
  end
end
