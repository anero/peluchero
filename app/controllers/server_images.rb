Peluchero::App.controllers :server_images do

  get :new do
    @server_image = ServerImage.new
    render 'new'
  end

  get :index do
    @server_images = ServerImage.all.order('created_at DESC')
    render 'server_images/index'
  end

  post :create do
    @server_image = ServerImage.new(params[:server_image])
    if @server_image.save
      redirect url(:server_images, :index), success: 'Imagen creada exitosamente'
    else
      render 'new'
    end
  end
end
