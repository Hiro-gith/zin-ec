module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  # キーワード引数でsizeを80にする
  def gravatar_for(user, size: 80)
    # Digestライブラリのhexdigestメソッドを使って、MD5のハッシュ化をする
    # ハッシュ化前にメールアドレスを小文字にする
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end