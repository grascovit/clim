# frozen_string_literal: true

module Api
  module V1
    module Users
      class ClientsController < ApplicationController
        before_action :set_client, only: %i[destroy show update]

        def index
          render json: current_user.clients, status: :ok
        end

        def show
          render json: @client, status: :ok
        end

        def create
          @client = current_user.clients.new(client_params)

          if @client.save
            render json: @client, status: :created
          else
            render json: @client.errors.full_messages, status: :unprocessable_entity
          end
        end

        def update
          if @client.update(client_params)
            render json: @client, status: :ok
          else
            render json: @client.errors.full_messages, status: :unprocessable_entity
          end
        end

        def destroy
          @client.destroy

          head :no_content
        end

        private

        def client_params
          params.require(:client).permit(
            :name,
            :phone,
            address_attributes: %i[
              primary_address
              secondary_address
              number
              zip_code
              neighborhood
              city
              state
              country
              latitude
              longitude
              addressable_type
            ]
          )
        end

        def set_client
          @client = current_user.clients.find(params[:id])
        end
      end
    end
  end
end
