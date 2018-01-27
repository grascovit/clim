# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        @user = User.new(user_params)

        if @user.save
          render json: { user: UserSerializer.new(@user), token: token }, status: :created
        else
          render json: @user.errors.full_messages, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation
        )
      end

      def token
        Knock::AuthToken.new(payload: { sub: @user.id }).token
      end
    end
  end
end
