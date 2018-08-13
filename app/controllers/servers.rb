Peluchero::App.controllers :servers do
  get :launch do
    if params[:server_image_id].blank?
      halt 400, 'Missing server_image_id' and return
    end

    @server_image = ServerImage.find(params[:server_image_id])
    @server = Server.new(server_image: @server_image)

    render 'launch'
  end

  post :launch, map: '/servers/launch' do
    @server_image = ServerImage.find(params[:server].delete(:server_image_id))

    terminate_at = params[:server].delete(:terminate_at)
    if terminate_at.present?
      terminate_at = Chronic.parse(terminate_at, { endian_precedence: [:little, :middle] }) # Parse string as date time to set correct time zone on Time object
    end

    @server = @server_image.servers.build(params[:server].merge(status: 'pending', terminate_at: terminate_at))

    render :launch and return unless @server.save

    client = Aws::EC2::Client.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
    resp = client.run_instances(
      image_id: @server_image.ami_id,
      security_group_ids: [ @server.security_group ],
      instance_type: @server.instance_type,
      subnet_id: ENV['AWS_SUBNET'],
      max_count: 1,
      min_count: 1
    )

    if resp.instances.count == 1
      instance = resp.instances.first
      @server.instance_id = instance.instance_id
      @server.save!

      redirect '/', success: 'El servidor se lanzó correctamente'
    else
      Padrino.logger.error("Error al lanzar la instancia EC2: #{resp.inspect}")
      render :launch
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