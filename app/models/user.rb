class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :incidents, dependent: :destroy

  enum :role, { reporter: 0, approver: 1 }

  normalizes :email_address, with: ->(email) { email.strip.downcase }
end
