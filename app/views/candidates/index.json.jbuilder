# frozen_string_literal: true

json.status Candidate::STATUS_VALUES

json.candidates @candidates do |candidate|
  json.id        candidate.id
  json.firstName candidate.first_name
  json.lastName  candidate.last_name
  json.jobTitle  candidate.role
  json.status    candidate.status
  json.score     candidate.score
  json.likes     candidate.likes
end
