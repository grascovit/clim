# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    module Clients
      RSpec.describe 'TasksController', type: :request do
        let(:user) { create(:user) }
        let(:client) { create(:client, user: user) }
        let(:valid_params) { attributes_for(:task) }
        let(:invalid_params) do
          {
            title: nil,
            description: nil,
            start_at: nil,
            finish_at: nil,
            service_fee: nil
          }
        end

        describe 'GET #index' do
          before do
            get api_v1_client_tasks_path(client),
                headers: authenticated_header(user)
          end

          context 'when the client has tasks' do
            it 'returns client tasks list' do
              expect(response).to match_response_schema('v1/tasks')
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end

          context 'when client does not have tasks' do
            it 'returns an empty list' do
              expect(JSON.parse(response.body)).to eq([])
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end
        end

        describe 'GET #show' do
          context 'when the requested task exists' do
            let(:task) { create(:task, client: client) }

            before do
              get api_v1_client_task_path(client, task),
                  headers: authenticated_header(user)
            end

            it 'returns the task' do
              expect(response).to match_response_schema('v1/task')
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end
          end

          context 'when the requested task does not belong to current user' do
            let(:task) { create(:task) }

            it 'raises not found exception' do
              expect do
                get api_v1_client_task_path(client, task),
                    headers: authenticated_header(user)
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
        end

        describe 'POST #create' do
          context 'with valid params' do
            it 'creates a new task' do
              expect do
                post api_v1_client_tasks_path(client),
                     headers: authenticated_header(user),
                     params: { task: valid_params }
              end.to change(Client, :count).by(1)
            end

            it 'returns 201 http status' do
              post api_v1_client_tasks_path(client),
                   headers: authenticated_header(user),
                   params: { task: valid_params }

              expect(response).to have_http_status(:created)
            end

            it 'returns the created task' do
              post api_v1_client_tasks_path(client),
                   headers: authenticated_header(user),
                   params: { task: valid_params }

              expect(response).to match_response_schema('v1/task')
            end
          end

          context 'with invalid params' do
            it 'does not create a new task' do
              expect do
                post api_v1_client_tasks_path(client),
                     headers: authenticated_header(user),
                     params: { task: invalid_params }
              end.not_to change(Task, :count)
            end

            it 'returns 422 http status' do
              post api_v1_client_tasks_path(client),
                   headers: authenticated_header(user),
                   params: { task: invalid_params }

              expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns the task errors' do
              post api_v1_client_tasks_path(client),
                   headers: authenticated_header(user),
                   params: { task: invalid_params }

              expect(JSON.parse(response.body)).to match_array(
                [
                  "Title can't be blank",
                  "Start at can't be blank",
                  "Service fee can't be blank"
                ]
              )
            end
          end
        end

        describe 'PUT/PATCH #update' do
          let(:task) { create(:task, client: client) }

          context 'with valid params' do
            let(:new_params) do
              {
                title: 'Task title',
                service_fee: 300.50
              }
            end

            before do
              put api_v1_client_task_path(client, task),
                  headers: authenticated_header(user),
                  params: { task: new_params }
            end

            it 'updates task data' do
              task.reload

              expect(task.title).to eq(new_params[:title])
            end

            it 'returns 200 http status' do
              expect(response).to have_http_status(:ok)
            end

            it 'returns the updated task' do
              expect(response).to match_response_schema('v1/task')
            end
          end

          context 'with invalid params' do
            it 'does not update task data' do
              expect do
                put api_v1_client_task_path(client, task),
                    headers: authenticated_header(user),
                    params: { task: invalid_params }
                task.reload
              end.not_to change(task, :title)
            end

            it 'returns 422 http status' do
              put api_v1_client_task_path(client, task),
                  headers: authenticated_header(user),
                  params: { task: invalid_params }

              expect(response).to have_http_status(:unprocessable_entity)
            end

            it 'returns the task errors' do
              put api_v1_client_task_path(client, task),
                  headers: authenticated_header(user),
                  params: { task: invalid_params }

              expect(JSON.parse(response.body)).to match_array(
                [
                  "Title can't be blank",
                  "Start at can't be blank",
                  "Service fee can't be blank"
                ]
              )
            end
          end

          context 'when task does not belong to current user' do
            let(:another_task) { create(:task) }

            it 'raises not found exception' do
              expect do
                put api_v1_client_task_path(client, another_task),
                    headers: authenticated_header(user),
                    params: { task: valid_params }
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
        end

        describe 'DELETE #destroy' do
          context 'when task belongs to current user' do
            let!(:task) { create(:task, client: client) }

            it 'deletes the task' do
              expect do
                delete api_v1_client_task_path(client, task),
                       headers: authenticated_header(user)
              end.to change(Task, :count).by(-1)
            end

            it 'returns 204 http status' do
              delete api_v1_client_task_path(client, task),
                     headers: authenticated_header(user)

              expect(response).to have_http_status(:no_content)
            end
          end

          context 'when task does not belong to current user' do
            let!(:another_task) { create(:task) }

            it 'raises not found exception' do
              expect do
                delete api_v1_client_task_path(client, another_task),
                       headers: authenticated_header(user)
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
        end
      end
    end
  end
end
