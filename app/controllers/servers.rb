Peluchero::App.controllers :servers do
  get :index do
    @servers = Server.all.order('updated_at DESC')
    render 'servers/index'
  end

  get :launch do
    if params[:server_image_id].blank?
      halt 400, 'Missing server_image_id' and return
    end

    @server_image = ServerImage.find(params[:server_image_id])
    @server = Server.new(server_image: @server_image, terminate_at: Time.zone.now + 4.hours)

    render 'servers/launch'
  end

  post :launch, map: '/servers/launch' do
    @server_image = ServerImage.find(params[:server].delete(:server_image_id))

    terminate_at = params[:server].delete(:terminate_at)
    if terminate_at.present?
      terminate_at = Chronic.parse(terminate_at, { endian_precedence: [:little, :middle] }) # Parse string as date time to set correct time zone on Time object
    end

    @server = @server_image.servers.build(params[:server].merge(status: 'pending', terminate_at: terminate_at, launched_by: current_account))

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

  post :refresh do
    Server.not_terminated.each {|s| s.refresh_status! }

    redirect '/', success: 'Estado de servidores actualizado'
  end

  put :terminate, map: '/servers/:id/terminate' do
    @server = Server.find(params[:id])
    @server.terminate!

    redirect '/', success: 'Apagando el servidor'
  end
end
