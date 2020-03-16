# frozen_string_literal: true

class CandidatesController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        @candidates = Candidate.all
      end
      format.html { ; }
    end
  end
end
