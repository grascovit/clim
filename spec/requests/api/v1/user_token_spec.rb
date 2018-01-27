# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'UserTokenController', type: :request do
      let(:user) { create(:user) }
      let(:valid_params) do
        {
          email: user.email,
          password: user.password
        }
      end
      let(:invalid_params) do
        {
          email: 'wrong',
          password: 'wrong'
        }
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'returns 201 http status' do
            post api_v1_user_token_path, params: { auth: valid_params }

            expect(response).to have_http_status(:created)
          end

          it 'returns a json with user and token' do
            post api_v1_user_token_path, params: { auth: valid_params }

            expect(response).to match_response_schema('v1/user_token')
          end
        end

        context 'with invalid params' do
          it 'returns 404 http status' do
            post api_v1_user_token_path, params: { auth: invalid_params }

            expect(response).to have_http_status(:not_found)
          end
        end
      end
    end
  end
end
