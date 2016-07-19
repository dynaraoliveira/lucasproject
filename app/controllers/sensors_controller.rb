class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    @sensors = Sensor.all
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
    @chave = params[:chave]
    @s0 = params[:s0]
    @s1 = params[:s1]
    @s2 = params[:s2]
    @s3 = params[:s3]
    @s4 = params[:s4]
    @s5 = params[:s5]
    
    
    @sensor = Sensor.create(chave: @chave, sensor0: @s0, sensor1: @s1, sensor2: @s2, sensor3: @s3, sensor4: @s4, sensor5: @s5)
  
    respond_to do |format|
      if @sensor
        format.html { redirect_to @sensor, notice: 'Sensor was successfully created.' }
        format.json { render :show, status: :created, location: @sensor }
      else
        format.html { render :new }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
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
    
end
