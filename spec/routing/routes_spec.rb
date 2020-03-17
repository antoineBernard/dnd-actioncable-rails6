# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes', type: :routing do
  it { expect(get('/'))          .to route_to 'candidates#index' }
  it { expect(get('/candidates')).to route_to 'candidates#index' }
  it { expect(post('/update_status/20/to_meet')).to route_to 'candidates#update_status', id: '20', status: 'to_meet' }

  it { expect(candidates_path) .to eq '/candidates' }
  it { expect(update_status_path(20, 'to_meet')).to eq '/update_status/20/to_meet' }
end
