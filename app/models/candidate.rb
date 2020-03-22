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

  before_create :set_default_rank

  def set_default_rank
    self.rank = Candidate.count
  end

  def apply_rank_update(new_rank)
    old_rank = rank

    candidates = Candidate.all

    if new_rank < old_rank
      candidates.where(rank: new_rank..(old_rank - 1)).map { |c| c.update_attributes(rank: c.rank + 1) }
    else
      candidates.where(rank: (old_rank + 1)..new_rank).map { |c| c.update_attributes(rank: c.rank - 1) }
    end

    update_attributes(rank: new_rank)
  end
end
