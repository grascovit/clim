# frozen_string_literal: true

module RequestHelper
  def authenticated_header(user)
    {
      Authorization: "Bearer #{token(user)}"
    }
  end

  private

  def token(user)
    Knock::AuthToken.new(payload: { sub: user.id }).token
  end
end
