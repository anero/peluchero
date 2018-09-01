Peluchero::App.controllers do

  get :index do
    @games = Game.all

    render 'index'
  end

  get :admin do
    render 'admin'
  end
end
