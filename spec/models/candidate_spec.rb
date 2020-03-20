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

  describe '#set_default_rank' do
    let(:new_candidates) { create_list :candidate, 2 }

    it 'should auto rank new candidates' do
      expect(new_candidates.map(&:rank)).to eq [0, 1]
    end
  end

  describe '#apply_rank_update' do
    let!(:first)  { create :candidate }
    let!(:second) { create :candidate }
    let!(:third)  { create :candidate }
    let!(:fourth) { create :candidate }
    let!(:five)   { create :candidate }
    let!(:six)    { create :candidate }

    describe 'when i place fourth in second position' do
      before { fourth.apply_rank_update 1 }

      it 'should update candidates rank' do
        expect([
          first .reload,
          fourth.reload,
          second.reload,
          third .reload,
          five  .reload,
          six   .reload
        ].map(&:rank)).to eq [0, 1, 2, 3, 4, 5]
      end
    end

    describe 'when i place second in fourth position' do
      before { second.apply_rank_update 3 }

      it 'should update candidates rank' do
        expect([
          first .reload,
          third .reload,
          fourth.reload,
          second.reload,
          five  .reload,
          six   .reload
        ].map(&:rank)).to eq [0, 1, 2, 3, 4, 5]
      end
    end

    describe 'when i place five in first position' do
      before { five.apply_rank_update 0 }

      it 'should update candidates rank' do
        expect([
          five  .reload,
          first .reload,
          second.reload,
          third .reload,
          fourth.reload,
          six   .reload
        ].map(&:rank)).to eq [0, 1, 2, 3, 4, 5]
      end
    end
  end
end
