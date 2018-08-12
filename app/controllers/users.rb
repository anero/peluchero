Peluchero::App.controllers :users do
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
