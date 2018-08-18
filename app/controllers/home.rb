Peluchero::App.controllers do

  get :index do
    @servers = Server.where(status: %w(pending running)).order('updated_at DESC')

    render 'index'
  end
end
