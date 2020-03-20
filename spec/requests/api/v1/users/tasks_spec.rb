# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    module Users
      RSpec.describe 'TasksController', type: :request do
        let(:user) { create(:user) }
        let(:client) { create(:client, user: user) }

        describe 'GET #index' do
          context 'when the user has tasks' do
            before do
              create(:task, client: client)

              get api_v1_user_tasks_path(user),
                  headers: authenticated_header(user)
            end

            it 'returns user tasks list' do
              expect(response).to match_json_schema('v1/tasks')
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end

          context 'when user does not have tasks' do
            before do
              get api_v1_user_tasks_path(user),
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
      end
    end
  end
end
