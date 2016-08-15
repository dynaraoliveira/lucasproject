class SensorsController < ApplicationController
  before_filter :authorize_user
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:chave,:s0,:s1,:s2,:s3,:s4,:s5,:data)
    end
    
    def authorize_user
      unless current_user
        redirect_to root_path
      end
    end
    
end
