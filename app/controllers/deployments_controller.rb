class DeploymentsController < ApplicationController

  def index
    authorize! :read, Deployment
    if params[:study_id]
      study = Study.find(params[:study_id])
    end
    respond_to do |format|
      format.html {
        # The grid page is really only meant for people that
        # can adminster the study
        if params[:study_id]
          authorize! :manage, study
        else
          authorize! :manage, Study
        end
        render :layout => 'admin'
      }
      format.geo {
        if params[:study_id]
          deps = Deployment.includes(:study, :retrieval, :otn_array).where(["study_id = ?",study])
        else
          deps = Deployment.includes(:study, :retrieval, :otn_array).order('study_id ASC')
        end
        render :json =>
          deps.as_json({
            :only => [nil],
            :methods => [:geojson],
            :include => { :otn_array => 
              { :only => [:code, :description, :waterbody] }
            }
          })
      }
      format.dataTable {
        columns = params[:sColumns].split(",")
        sort_direction = params[:sSortDir_0]
        sort_column = columns[params[:iSortCol_0].to_i]
        page_num = (params[:iDisplayStart].to_i / params[:iDisplayLength].to_i) + 1
        # The grid page is really only meant for people that
        # can adminster the study
        if params[:study_id]
          authorize! :manage, study
          deps = Deployment.includes(:retrieval, :study, :otn_array).where(["study_id = ?",study]).order("#{sort_column} #{sort_direction}").page(page_num.to_i).per(params[:iDisplayLength].to_i)
        else
          authorize! :manage, Study
          deps = Deployment.includes(:retrieval, :study, :otn_array).order("#{sort_column} #{sort_direction}").page(page_num.to_i).per(params[:iDisplayLength].to_i)
        end
        render :json => {
          :sEcho => params[:sEcho],
          :iTotalRecords => deps.total_count,
          :iTotalDisplayRecords => deps.total_count,
          :aaData => deps.as_json({
            :only => [:start, :station, :seasonal, :model, :frequency],
            :include => { :study => { :only => [:name] } },
            :methods => [:DT_RowId, :latitude, :longitude, :code, :ending]
          })
        }
      }
    end
  end

  def destroy
    @dep = Deployment.find(params[:id])
    authorize! :destroy, @dep
    @dep.destroy
    respond_to do |format|
      format.html
      format.js { render :json => nil, :status => :ok}
    end
  end
end
