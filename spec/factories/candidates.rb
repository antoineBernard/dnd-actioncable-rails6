# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    role       { FFaker::Job.title }
    score      { rand(0.0..5.0).round(2) }
    likes      { rand(0..10) }
  end
end
