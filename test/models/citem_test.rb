require 'test_helper'

class CitemTest < ActiveSupport::TestCase
  
  # 最も新しいものが最初にくる
  test "order should be most recent first" do
    assert_equal citems(:most_recent), Citem.first
  end
end
