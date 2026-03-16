class User < ApplicationRecord
  has_secure_password

  validates :nickname, presence: true, uniqueness: true, length: { in: 3..15}
  validates :password, presence: true, length: { in: 4..72 }, on: :create
end
