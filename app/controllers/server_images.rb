# frozen_string_literal: true

Peluchero::App.controllers :server_images do
  get :index do
    @server_images = ServerImage.live.order('created_at DESC')
    render 'server_images/index'
  end

  post :import, parent: :game do
    @game = Game.find(params[:game_id])
    @game.refresh_status!

    redirect url(:games, :show, id: params[:game_id]), success: 'Imagenes disponibles actualizadas'
  end
end
