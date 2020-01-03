class User < ApplicationRecord
  # save前にメールアドレスを小文字にして保存する
  before_save { email.downcase! }
  # 名前が空白、51文字以上(twitterに準拠)でfalse
  validates :name,  presence: true, length: { maximum: 50 }
  
  # メールアドレスが空白、257文字以上(RFC 5321に準拠)でfalse
  # 有効な正規表現に当てはまらなければfalse
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 256 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } #大文字小文字を問わず一意でなければfalse
  
  # セキュアなパスワードにするためのメソッド
  has_secure_password
  # パスワードが空白、8文字以下でfalse
  validates :password, presence: true, length: { minimum: 9 }
  
   # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    # テスト中のコストは最小(本番はあげる必要がある)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    # ハッシュ化
    BCrypt::Password.create(string, cost: cost)
  end
end
