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
          context 'when user has clients' do
            before do
              create(:client, user: user)

              get api_v1_user_clients_path(user),
                  headers: authenticated_header(user)
            end

            it 'returns user clients list' do
              expect(response).to match_response_schema('v1/clients')
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end

          context 'when user does not have clients' do
            before do
              get api_v1_user_clients_path(user),
                  headers: authenticated_header(user)
            end

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

            it 'returns the created client' do
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

            it 'returns the client errors' do
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

        describe 'PUT/PATCH #update' do
          let(:client) { create(:client, user: user) }

          context 'with valid params' do
            let(:new_params) do
              {
                name: 'Client name',
                phone: '+5562909203912'
              }
            end

            before do
              put api_v1_user_client_path(user, client),
                  headers: authenticated_header(user),
                  params: { client: new_params }
            end

            it 'updates client data' do
              client.reload

              expect(client.name).to eq(new_params[:name])
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end

            it 'returns the updated client' do
              expect(response).to match_response_schema('v1/client')
            end
          end

          context 'with invalid params' do
            it 'does not update client data' do
              expect do
                put api_v1_user_client_path(user, client),
                    headers: authenticated_header(user),
                    params: { client: invalid_params }
                client.reload
              end.not_to change(client, :name)
            end

            it 'returns 422 http status' do
              put api_v1_user_client_path(user, client),
                  headers: authenticated_header(user),
                  params: { client: invalid_params }

              expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns the client errors' do
              put api_v1_user_client_path(user, client),
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

          context 'when client does not belong to current user' do
            let(:another_client) { create(:client) }

            it 'raises not found exception' do
              expect do
                put api_v1_user_client_path(user, another_client),
                    headers: authenticated_header(user),
                    params: { client: valid_params }
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
        end

        describe 'DELETE #destroy' do
          context 'when client belongs to current user' do
            let!(:client) { create(:client, user: user) }

            it 'deletes the client' do
              expect do
                delete api_v1_user_client_path(user, client),
                       headers: authenticated_header(user)
              end.to change(Client, :count).by(-1)
            end

            it 'returns 204 http status' do
              delete api_v1_user_client_path(user, client),
                     headers: authenticated_header(user)

              expect(response).to have_http_status(:no_content)
            end
          end

          context 'when client does not belong to current user' do
            let!(:another_client) { create(:client) }

            it 'raises not found exception' do
              expect do
                delete api_v1_user_client_path(user, another_client),
                       headers: authenticated_header(user)
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
        end
      end
    end
  end
end
