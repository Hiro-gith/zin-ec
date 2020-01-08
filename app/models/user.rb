class User < ApplicationRecord
  # itemsと紐付ける、ユーザーと一緒に破棄される
  has_many :items, dependent: :destroy
  
  # 仮想のremember_token属性を作成する(データベースにはないがuser.remember_tokenが使える)
  attr_accessor :remember_token
  
  # save前にメールアドレスを小文字にして保存する
  before_save { email.downcase! }
  # 名前が空白、51文字以上(twitterに準拠)でfalse
  
  has_many :items, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
  
  # メールアドレスが空白、257文字以上(RFC 5321に準拠)でfalse
  # 有効な正規表現に当てはまらなければfalse
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 256 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } #大文字小文字を問わず一意でなければfalse
  
  # セキュアなパスワードにするためのメソッド
  has_secure_password
  # パスワードが空白、8文字以下でfalse 変更時はnilでも可。新規登録時はhas_secure_passwordによりnilはエラーになる
  validates :password, presence: true, length: { minimum: 9 }, allow_nil: true
  
  # kaminariのページネーション設定
  default_scope -> { order(created_at: :desc) }
  # 1ページに表示させる数
  paginates_per 30
  
   # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    # テスト中のコストは最小(本番はあげる必要がある)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    # ハッシュ化
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す(記憶トークンに使う)
  def User.new_token
    # 64種類の文字からランダムに22個選ばれる
    SecureRandom.urlsafe_base64
  end
  
  # 記憶トークンを作成し、ハッシュ化したものを記憶ダイジェストにする。
  # その後記憶ダイジェストをデータベースへ保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す(has_secure_passwordのと名前は同じだが別物)
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # データベースの記憶ダイジェストを消す
  def forget
    update_attribute(:remember_digest, nil)
  end
end
