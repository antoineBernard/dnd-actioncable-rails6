# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'candidates/index.json.jbuilder', type: :view do
  let(:candidates) { create_list :candidate, 4 }

  before { assign :candidates, candidates }

  subject!(:json_candidates) { JSON.parse(render)['candidates'] }

  context 'display status collection' do
    let(:expected_status) { CandidateDecorator.status_collection }

    it { expect(JSON.parse(render)['status']).to eq expected_status }
  end

  context 'display candidates information' do
    it do
      candidates.each_with_index do |candidate, index|
        json_candidate = json_candidates[index]

        aggregate_failures do
          expect(json_candidate['id'])        .to eq candidate.id
          expect(json_candidate['firstName']) .to eq candidate.first_name
          expect(json_candidate['lastName'])  .to eq candidate.last_name
          expect(json_candidate['jobTitle'])  .to eq candidate.role
          expect(json_candidate['status'])    .to eq candidate.status
          expect(json_candidate['score'])     .to eq candidate.score.round(1)
          expect(json_candidate['likes'])     .to eq candidate.likes
          expect(json_candidate['rank'])      .to eq candidate.rank

          expect(json_candidate.length).to eq 8
        end
      end
    end
  end
end
