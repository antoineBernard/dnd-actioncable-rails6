# frozen_string_literal: true

require 'rails_helper'

describe CandidateDecorator do
  it { expect(CandidateDecorator).to translate_field_values(:status) }
end
