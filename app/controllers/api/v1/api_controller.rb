# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      before_action :set_serializer_namespace

      private

      def set_serializer_namespace
        self.namespace_for_serializer = Api::V1
      end
    end
  end
end
