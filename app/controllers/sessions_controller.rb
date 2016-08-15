class SessionsController < ApplicationController
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to controller: 'equipamentusers', action: 'index'
    else
      flash.now[:danger] = 'Email ou senha inválido'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
