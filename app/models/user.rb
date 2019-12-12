# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :username, presence: true
  has_many :interests
  has_many :events, through: :interests
end
