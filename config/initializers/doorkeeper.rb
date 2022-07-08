# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  admin_authenticator do
    if current_user
      head :forbidden unless current_user.admin?
    else
      redirect_to new_user_session_path
    end
  end
end
