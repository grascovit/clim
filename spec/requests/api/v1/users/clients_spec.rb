# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    module Users
      RSpec.describe 'ClientsController', type: :request do
        let(:user) { create(:user) }
        let(:valid_params) { attributes_for(:client) }
        let(:invalid_params) do
          {
            name: nil,
            phone: nil
          }
        end

        describe 'GET #index' do
          before do
            get api_v1_user_clients_path(user),
                headers: authenticated_header(user)
          end

          context 'when user has clients' do
            it 'returns user clients list' do
              expect(response).to match_response_schema('v1/clients')
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end

          context 'when user does not have clients' do
            it 'returns an empty list' do
              expect(JSON.parse(response.body)).to eq([])
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end
        end

        describe 'GET #show' do
          context 'when the requested client exists' do
            let(:client) { create(:client, user: user) }

            before do
              get api_v1_user_client_path(user, client),
                  headers: authenticated_header(user)
            end

            it 'returns the client' do
              expect(response).to match_response_schema('v1/client')
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end

          context 'when the requested client does not belong to current user' do
            let(:client) { create(:client) }

            it 'raises not found exception' do
              expect do
                get api_v1_user_client_path(user, client),
                    headers: authenticated_header(user)
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
        end

        describe 'POST #create' do
          context 'with valid params' do
            it 'creates a new client' do
              expect do
                post api_v1_user_clients_path(user),
                     headers: authenticated_header(user),
                     params: { client: valid_params }
              end.to change(Client, :count).by(1)
            end

            it 'returns 201 http status' do
              post api_v1_user_clients_path(user),
                   headers: authenticated_header(user),
                   params: { client: valid_params }

              expect(response).to have_http_status(:created)
            end

            it 'returns the created user and token to authenticate' do
              post api_v1_user_clients_path(user),
                   headers: authenticated_header(user),
                   params: { client: valid_params }

              expect(response).to match_response_schema('v1/client')
            end
          end

          context 'with invalid params' do
            it 'does not create a new client' do
              expect do
                post api_v1_user_clients_path(user),
                     headers: authenticated_header(user),
                     params: { client: invalid_params }
              end.not_to change(Client, :count)
            end

            it 'returns 422 http status' do
              post api_v1_user_clients_path(user),
                   headers: authenticated_header(user),
                   params: { client: invalid_params }

              expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns the user errors' do
              post api_v1_user_clients_path(user),
                   headers: authenticated_header(user),
                   params: { client: invalid_params }

              expect(JSON.parse(response.body)).to match_array(
                [
                  "Name can't be blank",
                  "Phone can't be blank"
                ]
              )
            end
          end
        end

        skip 'PUT/PATCH #update' do
        end

        skip 'DELETE #destroy' do
        end
      end
    end
  end
end
