Peluchero::App.controllers :games do
  before :edit, :update, :show do
    @game = Game.find(params[:id])
  end

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

  get :edit, with: [:id] do
    render 'games/edit'
  end

  put :update, with: [:id] do
    if @game.update_attributes(params[:game])
      redirect url(:games, :index), success: 'Juego actualizado exitosamente'
    else
      flash[:alert] = 'No se pudo actualizar el juego'
      render 'games/edit'
    end
  end

  get :show, map: 'games/:id' do
    render 'games/show'
  end
end
