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
    
    labelsmes = []
    potencia1mes = []
    potencia2mes = []
    potencia3mes = []
    
    labelsano = []
    potencia1ano = []
    potencia2ano = []
    potencia3ano = []
    
    @sensors.each do |sensor|
      
      cs0 = ((sensor.sensor0 * 220) / 1023) / 0.707
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs2 = ((sensor.sensor2 * 220) / 1023) / 0.707
      
      cs3 = ((sensor.sensor3 * 20) / 204.6) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      cs5 = ((sensor.sensor5 * 20) / 204.6) / 0.707
      
      ts0 = cs0 * cs3
      ts1 = cs1 * cs4
      ts2 = cs2 * cs5
      
      labels.push({
        label: sensor.datainclusao.strftime('%T')
      })
      
      potencia1.push({
        value: ts0.to_i
      })
      
      potencia2.push({
        value: ts1.to_i
      })
      
      potencia3.push({
        value: ts2.to_i
      })
      
    end  
    
    @sensors.each do |sensor|
      
      cs0 = ((sensor.sensor0 * 220) / 1023) / 0.707
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs2 = ((sensor.sensor2 * 220) / 1023) / 0.707
      
      cs3 = ((sensor.sensor3 * 20) / 204.6) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      cs5 = ((sensor.sensor5 * 20) / 204.6) / 0.707
      
      ts0 = cs0 * cs3
      ts1 = cs1 * cs4
      ts2 = cs2 * cs5
    
      labelsmes.push({
        label: sensor.datainclusao.strftime('%F')
      })
      
      potencia1mes.push({
        value: ts0.to_i
      })
      
      potencia2mes.push({
        value: ts1.to_i
      })
      
      potencia3mes.push({
        value: ts2.to_i
      })
    
    end  
    
    @sensors.each do |sensor|
      
      cs0 = ((sensor.sensor0 * 220) / 1023) / 0.707
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs2 = ((sensor.sensor2 * 220) / 1023) / 0.707
      
      cs3 = ((sensor.sensor3 * 20) / 204.6) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      cs5 = ((sensor.sensor5 * 20) / 204.6) / 0.707
      
      ts0 = cs0 * cs3
      ts1 = cs1 * cs4
      ts2 = cs2 * cs5
      
      labelsano.push({
        label: sensor.datainclusao.month
      })
      
      potencia1ano.push({
        value: ts0.to_i
      })
      
      potencia2ano.push({
        value: ts1.to_i
      })
      
      potencia3ano.push({
        value: ts2.to_i
      })
      
    end
    
    @chart = Fusioncharts::Chart.new({
        width: "700",
        height: "300",
        type: "zoomline",
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
                        seriesname: "Potência 1",
                        data: [ potencia1 ]
                    },
                    {
                        seriesname: "Potência 2",
                        data: [ potencia2 ]
                    },
                    {
                        seriesname: "Potência 3",
                        data: [ potencia3 ]
                    }
              ]
        }
    })
    
    @chartmes = Fusioncharts::Chart.new({
        width: "700",
        height: "300",
        type: "mscolumn2d",
        renderAt: "chartmesContainer",
        dataSource: {
            chart: {
              caption: "",
              subCaption: "",
              xAxisname: "Dias",
              yAxisName: "Potência",
              forceAxisLimits: "1",
              numVisibleLabels: "31",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labelsmes ]}],
                dataset: [
                    {
                        seriesname: "Potência 1",
                        data: [ potencia1mes ]
                    },
                    {
                        seriesname: "Potência 2",
                        data: [ potencia2mes ]
                    },
                    {
                        seriesname: "Potência 3",
                        data: [ potencia3mes ]
                    }
              ]
        }
    })
    
    
    @chartano = Fusioncharts::Chart.new({
        width: "700",
        height: "300",
        type: "mscolumn2d",
        renderAt: "chartanoContainer",
        dataSource: {
            chart: {
              caption: "",
              subCaption: "",
              xAxisname: "Meses",
              yAxisName: "Potência",
              forceAxisLimits: "1",
              numVisibleLabels: "12",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labelsano ]}],
                dataset: [
                    {
                        seriesname: "Potência 1",
                        data: [ potencia1ano ]
                    },
                    {
                        seriesname: "Potência 2",
                        data: [ potencia2ano ]
                    },
                    {
                        seriesname: "Potência 3",
                        data: [ potencia3ano ]
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
