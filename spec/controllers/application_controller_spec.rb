# frozen_string_literal: true

require 'rails_helper'

describe ApplicationController, type: :controller do
  describe '#internal_server_error' do
    controller do
      skip_before_action :authenticate_user

      def index
        raise StandardError
      end
    end

    it 'returns internal server error message' do
      get :index

      expect(JSON.parse(response.body)['message']).to eq(I18n.t('controllers.internal_server_error'))
    end
  end

  describe '#record_not_found' do
    controller do
      skip_before_action :authenticate_user

      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    it 'returns not found message' do
      get :index

      expect(JSON.parse(response.body)['message']).to eq(I18n.t('controllers.record_not_found'))
    end
  end
end
