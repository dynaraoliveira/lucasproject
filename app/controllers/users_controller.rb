class UsersController < ApplicationController
  before_filter :authorize_user
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    
    if @user.save
      flash[:success] = "Usuário incluído com sucesso!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :usertype)
    end
    
    def authorize_user
      unless current_user
        if User.first!=nil
          redirect_to root_path
        end
      end
    end
end
