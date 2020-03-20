# frozen_string_literal: true

json.status CandidateDecorator.status_collection

json.candidates @candidates do |candidate|
  json.id        candidate.id
  json.firstName candidate.first_name
  json.lastName  candidate.last_name
  json.jobTitle  candidate.role
  json.status    candidate.status
  json.score     candidate.score.round(1)
  json.likes     candidate.likes
  json.rank      candidate.rank
end
