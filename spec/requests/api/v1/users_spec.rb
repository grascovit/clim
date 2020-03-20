# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'UsersController', type: :request do
      let(:valid_params) { attributes_for(:user) }
      let(:invalid_params) do
        {
          first_name: nil,
          email: nil,
          password: nil
        }
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new user' do
            expect do
              post api_v1_users_path, params: { user: valid_params }
            end.to change(User, :count).by(1)
          end

          it 'returns 201 http status' do
            post api_v1_users_path, params: { user: valid_params }

            expect(response).to have_http_status(:created)
          end

          it 'returns the created user and token to authenticate' do
            post api_v1_users_path, params: { user: valid_params }

            expect(response).to match_json_schema('v1/user_token')
          end
        end

        context 'with invalid params' do
          it 'does not create a new user' do
            expect do
              post api_v1_users_path, params: { user: invalid_params }
            end.not_to change(User, :count)
          end

          it 'returns 422 http status' do
            post api_v1_users_path, params: { user: invalid_params }

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'returns the user errors' do
            post api_v1_users_path, params: { user: invalid_params }

            expect(JSON.parse(response.body)).to match_array(
              [
                'Nome não pode ficar em branco',
                'Email não pode ficar em branco',
                'Senha não pode ficar em branco',
                'Senha é muito curto (mínimo: 6 caracteres)',
                'Você precisa informar CPF ou CNPJ'
              ]
            )
          end
        end
      end
    end
  end
end
