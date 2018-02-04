# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_at, :finish_at,
             :service_fee
end
