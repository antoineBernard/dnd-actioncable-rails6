# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  describe 'GET index' do
    let!(:candidates) { create_list(:candidate, 3) }

    specify 'html' do
      get :index, format: :html

      expect(response).to have_http_status(200)
      expect(assigns[:candidates]).to be nil
    end

    specify 'json' do
      get :index, format: :json

      expect(response).to have_http_status(200)
      expect(assigns[:candidates]).to eq(candidates)
    end
  end

  describe 'POST update' do
    let!(:candidate_to_promote) { create :candidate, status: 'to_meet' }

    before do
      server_double = double 'server_double'
      expect(ActionCable).to receive(:server).and_return server_double
      expect(server_double).to receive(:broadcast).with('candidates_channel',
                                                        updatedCandidates: [{
                                                          id:        candidate_to_promote.id,
                                                          firstName: candidate_to_promote.first_name,
                                                          lastName:  candidate_to_promote.last_name,
                                                          jobTitle:  candidate_to_promote.role,
                                                          status:    'hr_interview',
                                                          score:     candidate_to_promote.score,
                                                          likes:     candidate_to_promote.likes,
                                                          rank:      candidate_to_promote.rank
                                                        }].to_json)
    end

    specify do
      expect { post :update, params: { id: candidate_to_promote.id }, body: {status: 'hr_interview'}.to_json }
        .to change { candidate_to_promote.reload.status }.from('to_meet').to('hr_interview')

      expect(response).to have_http_status(:success)
    end
  end
end
