# frozen_string_literal: true

class Assessment < ApplicationRecord
  validates :comment, :rating, presence: true
  validates_inclusion_of :rating, in: 0..5
  belongs_to :place
  belongs_to :user
end
