class EquipamentusersController < ApplicationController
  before_filter :authorize_user
  before_action :set_equipamentuser, only: [:show, :edit, :update, :destroy]

  # GET /equipaments
  # GET /equipaments.json
  def index
    if session[:user_type] == 'A'
      @equipamentusers = Equipamentuser.all
    else
      @equipamentusers = Equipamentuser.where(user_id: session[:user_id])  
    end
  end

  # GET /equipaments/1
  # GET /equipaments/1.json
  def show
    @equipamentuser = Equipamentuser.find(params[:id])
  end

  # GET /equipaments/new
  def new
    @equipamentuser = Equipamentuser.new
  end

  # POST /equipaments
  # POST /equipaments.json
  def create
    @equipamentuser = Equipamentuser.new(equipamentuser_params)
    
    respond_to do |format|
      if @equipamentuser.save
        format.html { redirect_to equipamentusers_url, notice: 'Equipamento associado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /equipaments/1
  # DELETE /equipaments/1.json
  def destroy
    @equipamentuser.destroy
    respond_to do |format|
      format.html { redirect_to equipamentusers_url, notice: 'Associação deletada com sucesso.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipamentuser
      @equipamentuser = Equipamentuser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipamentuser_params
      params.require(:equipamentuser).permit(:equipament_id, :user_id)
    end
  
    def authorize_user
      unless current_user
        redirect_to root_path
      end
    end
end
