# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_application, class: Doorkeeper::Application do
    name { Faker::Games::Pokemon.name }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }
    uid { Faker::Code.npi }
    secret { Faker::Code.npi }
  end
end
