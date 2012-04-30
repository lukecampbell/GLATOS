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

  def edit
    @study = Study.includes(:user).find(params[:id])
    authorize! :update, @study
    respond_to do |format|
      format.html
    end
  end

  def update
    @study = Study.includes(:user).find(params[:id])
    authorize! :update, @study
    if @study.update_attributes(params[:study])
      flash[:notice] = 'Project was successfully updated.'
      redirect_to project_path(@study)
    else
      render :action => 'edit'
    end
  end

end
