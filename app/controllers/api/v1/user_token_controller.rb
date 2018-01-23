# frozen_string_literal: true

module Api
  module V1
    class UserTokenController < Knock::AuthTokenController
      def create
        render json: { user: entity, token: auth_token.token }, status: :created
      end
    end
  end
end
