class Api::V1::SensorsController < ApplicationController
  before_action :set_api_v1_sensor, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/sensors
  # GET /api/v1/sensors.json
  def index
    @api_v1_sensors = Sensor.all
    render json: @api_v1_sensors
  end

  # GET /api/v1/sensors/1
  # GET /api/v1/sensors/1.json
  def show
    render json: @api_v1_sensor
  end

  # GET /api/v1/sensors/new
  def new
    @api_v1_sensor = Api::V1::Sensor.new
  end

  # GET /api/v1/sensors/1/edit
  def edit
  end

  # POST /api/v1/sensors
  # POST /api/v1/sensors.json
  def create
    @api_v1_sensor = Sensor.new(api_v1_sensor_params)

    if @api_v1_sensor.save
      render json: @sensor
    else
      render json: @sensor.errors
    end
  end

  # PATCH/PUT /api/v1/sensors/1
  # PATCH/PUT /api/v1/sensors/1.json
  def update
  end

  # DELETE /api/v1/sensors/1
  # DELETE /api/v1/sensors/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_sensor
      @api_v1_sensor = Sensor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_sensor_params
      params.require(:sensor).permit(:chave,:sensor0,:sensor1,:sensor2,:sensor3,:sensor4,:sensor5,:datainclusao)
    end
    
end
