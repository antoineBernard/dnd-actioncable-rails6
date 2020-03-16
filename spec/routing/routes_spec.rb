# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'routes', type: :routing do
  it { expect(get('/'))          .to route_to 'candidates#index' }
  it { expect(get('/candidates')).to route_to 'candidates#index' }

  it { expect(candidates_path) .to eq '/candidates' }
end
