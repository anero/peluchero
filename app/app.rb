module Peluchero
  class App < Padrino::Application
    use ConnectionPoolManagement

    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    enable :sessions
    enable :authentication
    enable :store_location

    use OmniAuth::Builder do
      provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
    end

    set :login_page, '/users/unauthorized'
    set :admin_model, 'User'

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow '/users/unauthorized'
      role.allow '/sessions'
      role.allow '/auth'
    end

    access_control.roles_for :unauthorized do |role|
      role.allow '/users/unauthorized'
      role.allow '/users/pending'
    end

    access_control.roles_for :admin do |role|
      role.protect '/'
    end

    unless RACK_ENV == 'development'
      before do
        redirect request.url.sub('http', 'https') unless request.secure?
      end
    end

    before do
      unless current_account.nil?
        Raven.user_context(id: current_account.id, email: current_account.email)
      end
    end
  end
end
