class SensorsController < ApplicationController
  before_filter :authorize_user
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    
    chart_params
    
    @diaini = params[:auxdata].to_date.beginning_of_day
    @diafim = params[:auxdata].to_date.end_of_day
    
    @mesini = params[:auxdata].to_date.beginning_of_month
    @mesfim = params[:auxdata].to_date.end_of_month
    
    @anoini = params[:auxdata].to_date.beginning_of_year
    @anofim = params[:auxdata].to_date.end_of_year
  
    @sensors = Sensor.where(chave: params[:chave]).order("datainclusao").all
    
    @sensors_dia = @sensors.where(datainclusao: @diaini..@diafim)
    @sensors_mes = @sensors.where(datainclusao: @mesini..@mesfim)
    @sensors_ano = @sensors.where(datainclusao: @anoini..@anofim)
    
    labels = []
    potencia1 = []
    potencia2 = []
    potencia3 = []
    
    labelsmes = []
    potencia2mes = []
    
    labelsano = []
    potencia2ano = []
    
    @sensors_dia.each do |sensor|
      
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
    
    @ts1 = 0
    
    @sensors_mes.each do |sensor|
      
      @auxdia = sensor.datainclusao.day
      
      if @auxdia2 == nil
        @auxdia2 = sensor.datainclusao.day
      end
      
      if @auxdia != @auxdia2
      
        labelsmes.push({
          label: @label
        })
        
        potencia2mes.push({
          value: @ts1.to_i
        })
        
        @ts1 = 0
        
      end
      
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      
      @label = sensor.datainclusao.strftime('%F')
      @ts1 += (cs1 * cs4)
      @auxdia2 = sensor.datainclusao.day
      
    end
    
    if @auxdia == @auxdia2
      labelsmes.push({
        label: @label
      })
      
      potencia2mes.push({
        value: @ts1.to_i
      })
    end
    
    @ts1 = 0
    
    @sensors_ano.each do |sensor|
      
      @auxmes = sensor.datainclusao.month
      
      if @auxmes2 == nil
        @auxmes2 = sensor.datainclusao.month
      end
      
      if @auxdia != @auxdia2
      
        labelsano.push({
          label: @label
        })
        
        potencia2ano.push({
          value: @ts1.to_i
        })
        
        @ts1 = 0
        
      end
          
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
    
      @label = sensor.datainclusao.month
      @ts1 += (cs1 * cs4)
      @auxmes2 = sensor.datainclusao.month
      
    end
    
    if @auxmes == @auxmes2
      labelsano.push({
        label: @label
      })
      
      potencia2ano.push({
        value: @ts1.to_i
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
              showValues: "0",
              numberSuffix: "W/h"
            },
            categories: [{category: [ labelsmes ]}],
                dataset: [
                    {
                        seriesname: "Potência 2",
                        data: [ potencia2mes ]
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
              showValues: "0",
              numberSuffix: "W/h"
            },
            categories: [{category: [ labelsano ]}],
                dataset: [
                    {
                        seriesname: "Potência 2",
                        data: [ potencia2ano ]
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
    #def sensor_params
    #  params.require(:sensor).permit(:chave,:s0,:s1,:s2,:s3,:s4,:s5,:data)
    #end
    
    def chart_params
      params.permit(:ativa, :auxdata, :chave)
    end
    
    def authorize_user
      unless current_user
        redirect_to root_path
      end
    end
    
end
