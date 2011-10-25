class DeploymentsController < ApplicationController

  def index
    authorize! :read, Deployment
    @deps = Deployment.order('study_id ASC')
    respond_to do |format|
      format.geo { render :json =>
        @deps.as_json({
          :only => [nil],
          :methods => [:geojson]
        })
      }
      format.json { render :json =>
        @deps.as_json({
          :methods => [:DT_RowId, :geo],
          :only => [:start, :end, :study_id]
        })
      }
    end
  end
end
