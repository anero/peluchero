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

    set :login_page, '/sessions/new'
    set :admin_model, 'User'

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow '/sessions'
      role.allow '/sessions'
      role.allow '/auth'
      # role.allow '/health'
    end

    access_control.roles_for :admin do |role|
      role.protect '/'
    end
  end
end
