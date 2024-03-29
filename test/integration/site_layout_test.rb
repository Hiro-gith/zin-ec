require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  # rootへアクセス
  test "root links" do
    get root_path
    assert_template 'static_pages/arazin'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", magicdeal_path
    assert_select "a[href=?]", ranking_path
    assert_select "a[href=?]", help_path
  end
end
