Peluchero::App.controllers do

  get :index do
    @servers = Server.all.order('updated_at DESC')

    render 'index'
  end
end
