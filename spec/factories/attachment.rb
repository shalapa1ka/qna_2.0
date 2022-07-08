# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    file { Faker::Lorem.words }
  end
end
