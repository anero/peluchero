# frozen_string_literal: true

Peluchero::App.controllers :sessions do
  get :new do
    render 'new'
  end

  delete :destroy do
    set_current_account(nil)
    redirect url(:sessions, :new), success: 'Sesión cerrada'
  end

  get :auth, :map => '/auth/facebook/callback' do
    auth = request.env["omniauth.auth"]
    user = User.find_by_facebook_id(auth["uid"]) ||
                User.create_with_omniauth!(auth)

    if user.present? && user.persisted?
      set_current_account(user)
      redirect url(:index)
    else
      Padrino.logger.error("Error al autenticar usuario desde Facebook: #{auth.inspect}")

      redirect url(:sessions, :new), error: 'Error de autenticación'
    end
  end
end
