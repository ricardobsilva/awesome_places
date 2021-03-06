# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:places).dependent(:destroy) }
  it { is_expected.to have_many(:assessments).dependent(:destroy) }
  it { is_expected.to define_enum_for(:profile).with_values(common: 0, admin: 1) }
end
