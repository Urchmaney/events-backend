# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :interests
  has_many :users, through: :interests
  has_many :organizers
  has_many :comments
  has_many :comment_users, through: :comments, source: :user
end
