# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      before_action :find_user, only: :create

      def index
        respond_with(@questions = Question.all)
      end

      def show
        respond_with(@question = Question.find(params[:id]))
      end

      def create
        respond_with(@question = @user.questions.create({ title: params[:title], body: params[:body] }))
      end

      private

      def find_user
        query = "select resource_owner_id from oauth_access_grants where token = '#{params[:code]}'"
        user_id = ActiveRecord::Base.connection.execute(query).first['resource_owner_id']
        @user = User.find(user_id)
      end
    end
  end
end
