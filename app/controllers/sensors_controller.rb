class SensorsController < ApplicationController
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    
    if params[:auxdata] == nil
      session[:chave] = params[:chave]
      @sensors = Sensor.where(chave: params[:chave], datainclusao: [Date.today.beginning_of_day..Date.today.end_of_day]).order("datainclusao").all
    else  
      @sensors = Sensor.where(chave: session[:chave], datainclusao: [params[:auxdata].to_date.beginning_of_day..params[:auxdata].to_date.end_of_day]).order("datainclusao").all
    end 
    
    labels = []
    potencia1 = []
    potencia2 = []
    potencia3 = []
    
    @sensors.each do |sensor|
            
      @cs0 = ((sensor.sensor0 * 220) / 1023) / 0.707
      @cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      @cs2 = ((sensor.sensor2 * 220) / 1023) / 0.707
      
      @cs3 = ((sensor.sensor3 * 20) / 204.6) / 0.707
      @cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      @cs5 = ((sensor.sensor5 * 20) / 204.6) / 0.707
      
      @ts0 = @cs0 * @cs3
      @ts1 = @cs1 * @cs4
      @ts2 = @cs2 * @cs5
      
      @hora =  sensor.datainclusao.hour
      
      labels.push({
        label: @hora
      })
      
      potencia1.push({
        value: @ts0.to_i
      })
      
      potencia2.push({
        value: @ts1.to_i
      })
      
      potencia3.push({
        value: @ts2.to_i
      })
      
    end
    
    @chart = Fusioncharts::Chart.new({
        width: "700",
        height: "300",
        type: "msline",
        renderAt: "chartContainer",
        dataSource: {
            chart: {
              caption: "",
              subCaption: "",
              xAxisname: "Horas",
              yAxisName: "Potência",
              forceAxisLimits: "1",
              numVisibleLabels: "12",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labels ]}],
                dataset: [
                    {
                        seriesname: "Potência1",
                        data: [ potencia1 ]
                    },
                    {
                        seriesname: "Potência2",
                        data: [ potencia2 ]
                    },
                    {
                        seriesname: "Potência3",
                        data: [ potencia3 ]
                    }
              ]
        }
    })
    
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
  #  @sensor = Sensor.new(sensor_params)
  
  #  if @sensor.save
  #    render json: @sensor
  #  else
  #    render json: @sensor.errors
  #  end
  
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
