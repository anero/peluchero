Peluchero::App.controllers :servers do
  get :index do
    @servers = Server.all.order('updated_at DESC')
    render 'servers/index'
  end

  put :refresh, map: 'servers/:id/refresh' do
    @server = Server.find(params[:id])
    @server.refresh_status!
    flash[:success] = 'Estado de servidor actualizado'

    render 'servers/show'
  end

  get :launch, parent: :game do
    @game = Game.find(params[:game_id])
    @server = @game.servers.build(server_image: @server_image, terminate_at: Time.zone.now + 4.hours, security_group: @game.preferred_security_group)

    # If present, use param from query string for setting the server image, otherwise use the latest available from game
    if params[:server_image_id].present?
      @server.server_image = ServerImage.find(params[:server_image_id])
    else
      @server.server_image = @game.server_images.order('server_images.created_at DESC').first
    end

    render 'servers/launch'
  end

  post :launch, parent: :game do
    @game = Game.find(params[:game_id])

    terminate_at = params[:server].delete(:terminate_at)
    if terminate_at.present?
      terminate_at = Chronic.parse(terminate_at, { endian_precedence: [:little, :middle] }) # Parse string as date time to set correct time zone on Time object
    end

    @server = @game.servers.build(params[:server].merge(status: 'pending', terminate_at: terminate_at, launched_by: current_account))

    if @server.save
      begin
        @server.launch!
        redirect '/', success: 'El servidor se lanzó correctamente'
      rescue Server::ErrorOnLaunch
        redirect '/', error: 'Error al lanzar el servidor'
      end
    else
      render 'servers/launch'
    end
  end

  post :refresh_all do
    Server.not_terminated.each {|s| s.refresh_status! }

    redirect '/', success: 'Estado de servidores actualizado'
  end

  put :terminate, map: '/servers/:id/terminate' do
    @server = Server.find(params[:id])
    @server.terminate!

    redirect '/', success: 'Apagando el servidor'
  end

  get :show, map: 'servers/:id' do
    @server = Server.find(params[:id])
    render 'servers/show'
  end
end
