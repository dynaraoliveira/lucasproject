class UsersController < ApplicationController
  before_filter :authorize_user
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)    # Not the final implementation!
    
    if @user.save
      flash[:success] = "Usuário incluído com sucesso!"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'Usuário alterado com sucesso.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :usertype)
    end
    
    def authorize_user
      unless current_user
        if User.first != nil
          redirect_to root_path
        end
      end
    end
end
