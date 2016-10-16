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
    
    labelsdia = []
    limpezadia = []
    prodgerdia = []
    utilresdia = []
    economidia = []
    
    labelsmes = []
    limpezames = []
    prodgermes = []
    utilresmes = []
    economimes = []
    
    labelsano = []
    limpezaano = []
    prodgerano = []
    utilresano = []
    economiano = []
    
    
    @valor_dia = 0
    
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
      ts3 = ts2 - ts1
      
      @valor_dia += ts1.to_i
      
      labelsdia.push({
        label: sensor.datainclusao.strftime('%T')
      })
      
      limpezadia.push({
        value: ts0.to_i
      })
      
      prodgerdia.push({
        value: ts1.to_i
      })
      
      utilresdia.push({
        value: ts3.to_i
      })
      
      economidia.push({
        value: ts2.to_i
      })
      
    end
    
    @ts0 = 0
    @ts1 = 0
    @ts2 = 0
    @ts3 = 0
    
    @valor_mes = 0
    
    @sensors_mes.each do |sensor|
      
      @auxdia = sensor.datainclusao.day
      
      if @auxdia2 == nil
        @auxdia2 = sensor.datainclusao.day
      end
      
      if @auxdia != @auxdia2
        
        @valor_mes += @ts2
        
        labelsmes.push({
          label: @label
        })
        
        limpezames.push({
          value: @ts0.to_i
        })
        
        prodgermes.push({
          value: @ts1.to_i
        })
        
        utilresmes.push({
          value: @ts3.to_i
        })
        
        economimes.push({
          value: @ts2.to_i
        })
        
        @ts0 = 0
        @ts1 = 0
        @ts2 = 0
        @ts3 = 0
        
      end
      
      cs0 = ((sensor.sensor0 * 220) / 1023) / 0.707
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs2 = ((sensor.sensor2 * 220) / 1023) / 0.707
      
      cs3 = ((sensor.sensor3 * 20) / 204.6) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      cs5 = ((sensor.sensor5 * 20) / 204.6) / 0.707
      
      @ts0 += cs0 * cs3
      @ts1 += cs1 * cs4
      @ts2 += cs2 * cs5
      @ts3 += @ts2 - @ts1
      
      @label = sensor.datainclusao.strftime('%F')
      
      @auxdia2 = sensor.datainclusao.day
      
    end
    
    if @auxdia == @auxdia2
      
      @valor_mes += @ts2
      
      labelsmes.push({
        label: @label
      })
      
      limpezames.push({
        value: @ts0.to_i
      })
      
      prodgermes.push({
        value: @ts1.to_i
      })
      
      utilresmes.push({
        value: @ts3.to_i
      })
      
      economimes.push({
        value: @ts2.to_i
      })
      
    end
    
    @ts0 = 0
    @ts1 = 0
    @ts2 = 0
    @ts3 = 0
    
    @valor_ano = 0
    
    @sensors_ano.each do |sensor|
      
      @auxmes = sensor.datainclusao.month
      
      if @auxmes2 == nil
        @auxmes2 = sensor.datainclusao.month
      end
      
      if @auxmes != @auxmes2
        
        @valor_ano += @ts2
        
        labelsano.push({
          label: @label
        })
        
        limpezaano.push({
          value: @ts0.to_i
        })
        
        prodgerano.push({
          value: @ts1.to_i
        })
        
        utilresano.push({
          value: @ts3.to_i
        })
        
        economiano.push({
          value: @ts2.to_i
        })
        
        @ts0 = 0
        @ts1 = 0
        @ts2 = 0
        @ts3 = 0
        
      end
          
      cs0 = ((sensor.sensor0 * 220) / 1023) / 0.707
      cs1 = ((sensor.sensor1 * 220) / 1023) / 0.707
      cs2 = ((sensor.sensor2 * 220) / 1023) / 0.707
      
      cs3 = ((sensor.sensor3 * 20) / 204.6) / 0.707
      cs4 = ((sensor.sensor4 * 20) / 204.6) / 0.707
      cs5 = ((sensor.sensor5 * 20) / 204.6) / 0.707
      
      @ts0 += cs0 * cs3
      @ts1 += cs1 * cs4
      @ts2 += cs2 * cs5
      @ts3 += @ts2 - @ts1
      
      @label = sensor.datainclusao.month
      
      @auxmes2 = sensor.datainclusao.month
      
    end
    
    if @auxmes == @auxmes2
      
      @valor_ano += @ts2
      
      labelsano.push({
        label: @label
      })
      
      limpezaano.push({
        value: @ts0.to_i
      })
      
      prodgerano.push({
        value: @ts1.to_i
      })
      
      utilresano.push({
        value: @ts3.to_i
      })
      
      economiano.push({
        value: @ts2.to_i
      })
      
    end
    
    
    @chart = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "zoomline",
        renderAt: "chartContainer",
        dataSource: {
            chart: {
              caption: "Controle de manutenção",
              subCaption: "",
              xAxisname: "Horas",
              yAxisName: "Produção (kW)",
              forceAxisLimits: "1",
              numVisibleLabels: "12",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labelsdia ]}],
                dataset: [
                    {
                        seriesname: "Produção",
                        data: [ limpezadia ]
                    }
              ]
        }
    })
    
    @chart2 = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "zoomline",
        renderAt: "chart2Container",
        dataSource: {
            chart: {
              caption: "Produção Geral",
              subCaption: "",
              xAxisname: "Horas",
              yAxisName: "Produção (kW)",
              forceAxisLimits: "1",
              numVisibleLabels: "12",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labelsdia ]}],
                dataset: [
                    {
                        seriesname: "Produção",
                        data: [ prodgerdia ]
                    }
              ]
        }
    })
    
    @chart3 = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "zoomline",
        renderAt: "chart3Container",
        dataSource: {
            chart: {
              caption: "Controle de Consumo",
              subCaption: "",
              xAxisname: "Horas",
              yAxisName: "Consumo (kW)",
              forceAxisLimits: "1",
              numVisibleLabels: "12",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labelsdia ]}],
                dataset: [
                    {
                        seriesname: "Consumo",
                        data: [ utilresdia ]
                    }
              ]
        }
    })
    
    @chart4 = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "zoomline",
        renderAt: "chart4Container",
        dataSource: {
            chart: {
              caption: "Controle de Econômia",
              subCaption: "",
              xAxisname: "Horas",
              yAxisName: "Econômia (kW)",
              forceAxisLimits: "1",
              numVisibleLabels: "12",
              theme: "fint",
              exportEnabled: "1",
              showValues: "0"
            },
            categories: [{category: [ labelsdia ]}],
                dataset: [
                    {
                        seriesname: "Econômia",
                        data: [ economidia ]
                    }
              ]
        }
    })
    
    @chartmes = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chartmesContainer",
        dataSource: {
            chart: {
              caption: "Controle de manutenção",
              subCaption: "",
              xAxisname: "Dias",
              yAxisName: "Produção (kW/h)",
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
                        seriesname: "Produção",
                        data: [ limpezames ]
                    }
              ]
        }
    })
    
    @chart2mes = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chart2mesContainer",
        dataSource: {
            chart: {
              caption: "Produção Geral",
              subCaption: "",
              xAxisname: "Dias",
              yAxisName: "Produção (kW/h)",
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
                        seriesname: "Produção",
                        data: [ prodgermes ]
                    }
              ]
        }
    })
    
    @chart3mes = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chart3mesContainer",
        dataSource: {
            chart: {
              caption: "Controle de Consumo",
              subCaption: "",
              xAxisname: "Dias",
              yAxisName: "Consumo (kW/h)",
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
                        seriesname: "Consumo",
                        data: [ prodgermes ]
                    }
              ]
        }
    })
    
    @chart4mes = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chart4mesContainer",
        dataSource: {
            chart: {
              caption: "Controle de Econômia",
              subCaption: "",
              xAxisname: "Dias",
              yAxisName: "Econômia (kW/h)",
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
                        seriesname: "Econômia",
                        data: [ prodgermes ]
                    }
              ]
        }
    })
    
    @chartano = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chartanoContainer",
        dataSource: {
            chart: {
              caption: "Controle de manutenção",
              subCaption: "",
              xAxisname: "Meses",
              yAxisName: "Produção (kW/h)",
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
                        seriesname: "Produção",
                        data: [ limpezaano ]
                    }
              ]
        }
    })
    
    
    @chart2ano = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chart2anoContainer",
        dataSource: {
            chart: {
              caption: "Produção Geral",
              subCaption: "",
              xAxisname: "Meses",
              yAxisName: "Produção (kW/h)",
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
                        seriesname: "Produção",
                        data: [ prodgerano ]
                    }
              ]
        }
    })
    
    
    @chart3ano = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chart3anoContainer",
        dataSource: {
            chart: {
              caption: "Controle de Consumo",
              subCaption: "",
              xAxisname: "Meses",
              yAxisName: "Consumo (kW/h)",
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
                        seriesname: "Consumo",
                        data: [ utilresano ]
                    }
              ]
        }
    })
    
    
    @chart4ano = Fusioncharts::Chart.new({
        width: "450",
        height: "250",
        type: "mscolumn2d",
        renderAt: "chart4anoContainer",
        dataSource: {
            chart: {
              caption: "Controle de Econômia",
              subCaption: "",
              xAxisname: "Meses",
              yAxisName: "Econômia (kW/h)",
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
                        seriesname: "Econômia",
                        data: [ economiano ]
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
