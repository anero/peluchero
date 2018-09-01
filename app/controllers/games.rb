Peluchero::App.controllers :games do
  get :index do
    @games = Game.all
    render 'games/index'
  end

  get :new do
    @game = Game.new
    render 'games/new'
  end

  post :create do
    @game = Game.new(params[:game])

    if @game.save
      redirect url(:games, :index), success: 'Juego creado exitosamente'
    else
      render 'games/new'
    end
  end
end
