require 'test_helper'

class BoughtTest < ActiveSupport::TestCase
  # 最も新しいものが最初にくる
  test "order should be most recent first" do
    assert_equal boughts(:most_recent), Bought.first
  end
end
