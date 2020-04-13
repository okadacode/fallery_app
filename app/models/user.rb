class User < ApplicationRecord
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
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
  validates :icon, presence: true
  validates :header, presence: true
end
