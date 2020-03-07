require 'test_helper'

class ClipTest < ActiveSupport::TestCase
  # 最も新しいものが最初にくる
  test "order should be most recent first" do
    assert_equal clips(:most_recent), Clip.first
  end
end
