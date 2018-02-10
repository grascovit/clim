# frozen_string_literal: true

module Api
  module V1
    module Users
      class TasksController < ApiController
        def index
          @tasks = current_user.tasks.includes(:client, client: :address)
                               .sorted_by_start_at
                               .page(params[:page])
                               .per(20)

          render json: @tasks, status: :ok, include: ['client.address']
        end
      end
    end
  end
end
