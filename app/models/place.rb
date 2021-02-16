# frozen_string_literal: true

class Place < ApplicationRecord
  validates :lat, :lng, :name, :description, presence: true

  belongs_to :user
  has_many :assessments, dependent: :destroy
end
