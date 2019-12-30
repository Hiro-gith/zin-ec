module ApplicationHelper # すべてのビューで読み込まれる

  # ページごとの完全なタイトルを返す
  #デフォルト(引数を指定しないとき)の引数は""
  def full_title(page_title = '')
    base_title = "Arazin"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end