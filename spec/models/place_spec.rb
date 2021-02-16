# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Place, type: :model do
  it { is_expected.to validate_presence_of(:lat) }
  it { is_expected.to validate_presence_of(:lng) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to belong_to(:user) }
end
