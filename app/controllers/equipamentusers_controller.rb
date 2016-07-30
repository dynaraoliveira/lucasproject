class EquipamentusersController < ApplicationController
  before_filter :authorize_user
  before_action :set_equipamentuser, only: [:show, :edit, :update, :destroy]

  # GET /equipaments
  # GET /equipaments.json
  def index
    @equipamentusers = Equipamentuser.all
    #if current_user.usertype = 'A'
      #@equipamentusers = Equipamentuser.all
    #else
      #@equipamentusers = Equipamentuser.where(:user_id = current_user.user_id)
    #end
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

  # GET /equipaments/1/edit
  def edit
  end

  # POST /equipaments
  # POST /equipaments.json
  def create
    @equipamentuser = Equipamentuser.new(equipamentuser_params)
    
    respond_to do |format|
      if @equipamentuser.save
        format.html { redirect_to @equipamentuser, notice: 'Equipament was successfully created.' }
        format.json { render :show, status: :created, location: @equipamentuser }
      else
        format.html { render :new }
        format.json { render json: @equipamentuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipaments/1
  # PATCH/PUT /equipaments/1.json
  def update
    respond_to do |format|
      if @equipamentuser.update(equipamentuser_params)
        format.html { redirect_to @equipamentuser, notice: 'Equipament was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipamentuser }
      else
        format.html { render :edit }
        format.json { render json: @equipamentuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipaments/1
  # DELETE /equipaments/1.json
  def destroy
    @equipamentuser.destroy
    respond_to do |format|
      format.html { redirect_to equipamentusers_url, notice: 'Equipament was successfully destroyed.' }
      format.json { head :no_content }
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
