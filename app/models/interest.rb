# frozen_string_literal: true

class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
