# frozen_string_literal: true

class CandidatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.json do
        @candidates = Candidate.all
      end
      format.html { ; }
    end
  end

  def update_status
    candidate = Candidate.find(params[:id])

    candidate.update_attributes(status: params[:status])

    ActionCable.server.broadcast 'candidates_channel', updatedCandidate: {
      id: candidate.id, status: candidate.status
    }
  end
end
