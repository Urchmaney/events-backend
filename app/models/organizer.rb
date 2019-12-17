# frozen_string_literal: true

class Organizer < ApplicationRecord
  belongs_to :event
  validates :name, :role, presence: true
end
