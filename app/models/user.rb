class User < ApplicationRecord
  # save前にメールアドレスを小文字にして保存する
  before_save { email.downcase! }
  # 名前が空白、21文字以上でfalse
  validates :name,  presence: true, length: { maximum: 20 }
  
  # メールアドレスが空白、255文字以上でfalse
  # 有効な正規表現に当てはまらなければfalse
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } #大文字小文字を問わず一意でなければfalse
  
  # セキュアなパスワードにするためのメソッド
  has_secure_password
  # パスワードが空白、8文字以下でfalse
  validates :password, presence: true, length: { minimum: 9 }
end
