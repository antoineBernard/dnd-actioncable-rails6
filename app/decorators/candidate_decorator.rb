# frozen_string_literal: true

class CandidateDecorator < Draper::Decorator
  delegate_all

  include Translatable

  translate_values_of :status
end
