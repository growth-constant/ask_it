# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AskIt::PredefinedValue, type: :model do
  describe 'validations' do
    it 'creates a valid predefined_value' do
      predefined_value = create(:predefined_value)
      expect(predefined_value).to be_valid
    end

    it 'does not create a predefined_value with an empty or nil name field' do
      expect(build(:predefined_value, name: nil)).not_to be_valid
      expect(build(:predefined_value, name: '')).not_to be_valid
    end
  end
end
