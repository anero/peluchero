Peluchero::App.controllers :users do
  get :index do
    @users = User.all
    render 'users/index'
  end

  put :promote_to_admin, map: '/users/:id/promote' do
    @user = User.find(params[:id])
    @user.role = 'admin'
    @user.save!

    redirect url(:users, :index), success: 'Usuario promovido a Administrador'
  end

  put :demote_to_unauthorized, map: '/users/:id/demote' do
    @user = User.find(params[:id])
    @user.role = 'unauthorized'
    @user.save!

    redirect url(:users, :index), success: 'Usuario ya no es Administrador'
  end

  get :unauthorized do
    if current_account.blank?
      redirect url(:sessions, :new)
    elsif current_account.pending_approval?
      redirect url(:users, :pending)
    else
      redirect url(:index)
    end
  end

  get :pending do
    render :pending
  end
end
