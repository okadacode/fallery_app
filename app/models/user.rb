class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.name = name.downcase }
  before_save { self.email = email.downcase }
  mount_uploader :icon, IconUploader
  mount_uploader :header, HeaderUploader
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]+\z/i
  validates :name, presence: true, length: { maximum: 16 },
                   format: { with: VALID_NAME_REGEX },
                   uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :nickname, presence: true, length: { maximum: 32 }
  validates :description, length: { maximum: 255 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validate :images_size

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def images_size
      if icon.size > 1.megabytes
        errors.add(:icon, "の画像のサイズが大きすぎます(最大1MB)")
      end
      if header.size > 1.megabytes
        errors.add(:header, "の画像のファイルのサイズが大きすぎます(最大1MB)")
      end
    end
end
