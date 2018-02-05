# frozen_string_literal: true

module Api
  module V1
    module Clients
      class TasksController < ApplicationController
        before_action :set_client
        before_action :set_task, only: %i[show update destroy]

        def index
          @tasks = @client.tasks.sorted_by_start_at.page(params[:page]).per(20)

          render json: @tasks, status: :ok
        end

        def show
          render json: @task, status: :ok
        end

        def create
          @task = @client.tasks.new(task_params)

          if @task.save
            render json: @task, status: :created
          else
            render json: @task.errors.full_messages, status: :unprocessable_entity
          end
        end

        def update
          if @task.update(task_params)
            render json: @task, status: :ok
          else
            render json: @task.errors.full_messages, status: :unprocessable_entity
          end
        end

        def destroy
          @task.destroy

          head :no_content
        end

        private

        def task_params
          params.require(:task).permit(
            :title,
            :description,
            :start_at,
            :finish_at,
            :service_fee
          )
        end

        def set_client
          @client = current_user.clients.find(params[:client_id])
        end

        def set_task
          @task = @client.tasks.find(params[:id])
        end
      end
    end
  end
end
