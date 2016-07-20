class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    #@sensors = Sensor.where(premium: true).order("created_at DESC").all
    @sensors = Sensor.order("datainclusao").all
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = Sensor.new(sensor_params)
  
    if @sensor.save
      render json: @sensor
    else
      render json: @sensor.errors
    end
  
  #  @sensor = Sensor.new(sensor_params)
  
  #  respond_to do |format|
  #    if @sensor.save
  #      format.html { redirect_to @sensor, notice: 'Sensor was successfully created.' }
  #      format.json { render :show, status: :created, location: @sensor }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @sensor.errors, status: :unprocessable_entity }
  #    end
  #  end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:chave,:s0,:s1,:s2,:s3,:s4,:s5,:data)
    end
end
