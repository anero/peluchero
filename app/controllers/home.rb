Peluchero::App.controllers do

  get :index do
    @servers = Server.not_terminated.order('updated_at DESC')

    render 'index'
  end
end
