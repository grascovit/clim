# frozen_string_literal: true

module Api
  module V1
    class TaskSerializer < ActiveModel::Serializer
      attributes :id, :title, :description, :start_at, :finish_at,
                 :service_fee

      belongs_to :client, serializer: ClientSerializer
    end
  end
end
