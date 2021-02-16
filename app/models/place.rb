# frozen_string_literal: true

class Place < ApplicationRecord
  acts_as_mappable lat_column_name: :lat, lng_column_name: :lng

  validates :lat, :lng, :name, :description, presence: true

  belongs_to :user
  has_many :assessments, dependent: :destroy

  scope :list_mode, -> { all.order(name: :asc) }
  scope :map_mode, ->(lat, lng) { by_distance(origin: [lat, lng]) }
end
