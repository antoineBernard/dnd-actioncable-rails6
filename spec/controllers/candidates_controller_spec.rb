# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CandidatesController, type: :controller do
  describe 'GET index' do
    let!(:candidates) { create_list :candidate, 3 }

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
end
