# frozen_string_literal: true

class Place < ApplicationRecord
  validates :lat, :lng, :name, :description, presence: true

  belongs_to :user
end
