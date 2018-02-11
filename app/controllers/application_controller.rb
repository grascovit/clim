# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def internal_server_error
    render json: { message: I18n.t('controllers.internal_server_error') }, status: :internal_server_error
  end

  def record_not_found
    render json: { message: I18n.t('controllers.record_not_found') }, status: :not_found
  end
end
