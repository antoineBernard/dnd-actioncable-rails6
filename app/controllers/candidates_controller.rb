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

    candidate.assign_attributes(status: params[:status])

    if candidate.save
      ActionCable.server.broadcast 'candidates_channel', updatedCandidate: {
        id: candidate.id, status: candidate.status
      }

      render plain: { success: true }.to_json, status: 200, content_type: 'application/json'
    else
      render json: { error: candidate.errors.messages }, status: :bad_request
    end
  end
end
