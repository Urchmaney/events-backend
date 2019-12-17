# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, :firstname, :lastname, presence: true
  has_many :interests
  has_many :events, through: :interests
  has_many :comments
  has_many :events_commented, through: :comments, source: :event
end
