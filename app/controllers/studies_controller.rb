class StudiesController < ApplicationController

  def index
    @studies = Study.order(:id)
    respond_to do |format|
      format.html
      format.json {
        render :json => @studies.as_json({

        })
      }
      format.dataTable {

      }
    end
  end

  def show
    @study = Study.includes(:user, :deployments, :tags).find(params[:id])
    respond_to do |format|
      format.html
    end
  end

end
