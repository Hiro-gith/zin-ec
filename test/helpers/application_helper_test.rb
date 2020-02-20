require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  # full title helperの中身
  test "full title helper" do
    assert_equal full_title,         "Zin"
    assert_equal full_title("Home"), "Home | Zin"
  end
end