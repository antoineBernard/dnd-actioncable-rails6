# frozen_string_literal: true

class Candidate < ApplicationRecord
  STATUS_VALUES = %w[
    to_meet
    hr_interview
    tech_review
    manager_interview
  ].freeze

  validates :first_name, presence: true
  validates :last_name,  presence: true

  validates :status, presence: true, inclusion: { in: STATUS_VALUES }
end
