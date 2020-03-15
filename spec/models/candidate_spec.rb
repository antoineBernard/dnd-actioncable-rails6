# frozen_string_literal: true

require 'rails_helper'

describe Candidate, type: :model do
  describe 'validations' do
    it { expect(subject).to validate_presence_of(:first_name) }
    it { expect(subject).to validate_presence_of(:last_name) }
  end

  describe 'status values validation' do
    let(:expected_status_values) do
      %w[
        to_meet
        hr_interview
        tech_review
        manager_interview
      ]
    end

    specify 'should have all status values' do
      expected_status_values.each do |status|
        expect(Candidate::STATUS_VALUES).to include status
      end
    end
  end
end
