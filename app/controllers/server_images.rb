Peluchero::App.controllers :server_images do

  get :new do
    @server_image = ServerImage.new
    render 'new'
  end

  get :index do
    @server_images = ServerImage.live.order('created_at DESC')
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

  put :archive, map: '/server_images/:id/archive' do
    @server_image = ServerImage.find(params[:id])
    @server_image.archive!

    redirect url(:server_images, :index), success: 'Imagen archivada exitosamente'
  end
end
