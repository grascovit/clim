# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  let(:valid_params) { attributes_for(:user) }

  let(:invalid_params) do
    {
      first_name: nil,
      email: nil,
      password: nil
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post api_v1_users_path, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end

      it 'returns 201 http status' do
        post api_v1_users_path, params: { user: valid_params }

        expect(response).to have_http_status(:created)
      end

      it 'returns the created user' do
        post api_v1_users_path, params: { user: valid_params }

        expect(response).to match_response_schema('v1/user')
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect do
          post api_v1_users_path, params: { user: invalid_params }
        end.not_to change(User, :count)
      end

      it 'returns 422 http status' do
        post api_v1_users_path, params: { user: invalid_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the user errors' do
        post api_v1_users_path, params: { user: invalid_params }

        expect(JSON.parse(response.body)).to match_array(
          [
            "First name can't be blank",
            "Email can't be blank",
            "Password can't be blank",
            'Password is too short (minimum is 6 characters)'
          ]
        )
      end
    end
  end
end
