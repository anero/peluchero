Peluchero::App.controllers :servers do

  post :launch, map: '/servers/launch' do
    @server_image = ServerImage.find(params[:server].delete(:server_image_id))
    @server = @server_image.servers.build(params[:server].merge(status: 'not_launched'))

    unless @server.save
      render 'server_images/launch' and return
    end

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
      @server.status = 'launching'
      @server.save!
      redirect '/', success: 'El servidor se lanzó correctamente'
    else
      Padrino.logger.error("Error al lanzar la instancia EC2: #{resp.inspect}")
    end
  end

  post :refresh do
    redirect '/'
  end
end
