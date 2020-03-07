require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title ="Zin"
  end
  
  # Home
  test "should get arazin_home" do
    get root_path
    assert_response :success
    assert_select "title","Home | #{@base_title}"
  end
  
  # magicdeal
  test "should get magicdeal" do
    get magicdeal_path
    assert_response :success
    assert_select "title","Magicdeal | #{@base_title}"
  end
  
  # ranking
  test "should get ranking" do
    get ranking_path
    assert_response :success
    assert_select "title","Ranking | #{@base_title}"
  end
  
  # Help
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title","Help | #{@base_title}"
  end

end
