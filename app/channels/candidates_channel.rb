# frozen_string_literal: true

class CandidatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'candidates_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
