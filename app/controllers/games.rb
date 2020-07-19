# frozen_string_literal: true

Peluchero::App.controllers :games do
  before :show, :edit, :update do
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

  get :edit, with: :id do
    render 'games/edit'
  end

  put :update, with: :id do
    @game.assign_attributes(params[:game])

    if @game.save
      redirect url(:games, :index), success: 'Juego actualizado exitosamente'
    else
      render url(:games, :edit, id: @game.id)
    end
  end

  get :show, with: :id do
    render 'games/show'
  end
end
