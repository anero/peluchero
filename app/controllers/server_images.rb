Peluchero::App.controllers :server_images do

  get :new do
    @server_image = ServerImage.new
    render 'new'
  end

  post '/' do
    @server_image = ServerImage.new(params[:server_image])
    if @server_image.save
      redirect '/', success: 'Imagen creada exitosamente'
    else
      render 'new'
    end
  end
end
