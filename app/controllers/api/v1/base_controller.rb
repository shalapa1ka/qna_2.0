# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :doorkeeper_authorize!
      respond_to :json

      protected

      def current_resource_owner
        if doorkeeper_token
          @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id)
        else
          warden.authenticate(scope: :user)
        end
      end
    end
  end
end
