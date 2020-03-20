# frozen_string_literal: true

class CandidatesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.json do
        @candidates = Candidate.all.order(:rank)
      end
      format.html { ; }
    end
  end

  def update
    candidate = Candidate.find(params[:id])

    updatedData = JSON.parse(request.body.read)

    candidate.assign_attributes(status: updatedData['status'])

    if candidate.save
      candidate.apply_rank_update(updatedData['rank']) if updatedData['rank']

      ActionCable.server.broadcast 'candidates_channel', updatedCandidates: Candidate.all.order(:rank).map { |c| {
        id: c.id, firstName: c.first_name, lastName: c.last_name, jobTitle: c.role, status: c.status, score: c.score, likes: c.likes, rank: c.rank
      } }.to_json

      render plain: { success: true }.to_json, status: 200, content_type: 'application/json'
    else
      render json: { error: candidate.errors.messages }, status: :bad_request
    end
  end
end
