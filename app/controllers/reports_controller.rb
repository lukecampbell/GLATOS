class ReportsController < ApplicationController

  layout 'application'

  def index
    authorize! :manage, Report
    respond_to do |format|
      format.html { render :layout => 'admin'}
      format.dataTable {
        columns = params[:sColumns].split(",")
        sort_direction = params[:sSortDir_0]
        sort_column = columns[params[:iSortingCols].to_i]
        page_num = (params[:iDisplayStart].to_i / params[:iDisplayLength].to_i) + 1

        reports = Report.order("#{sort_column} #{sort_direction}").page(page_num.to_i).per(params[:iDisplayLength].to_i)
        render :json => {
          :sEcho => params[:sEcho],
          :iTotalRecords => reports.total_count,
          :iTotalDisplayRecords => reports.total_count,
          :aaData => reports.as_json({
            :methods => [:DT_RowId]
          })
        }
      }
    end
  end

  def new
    authorize! :create, Report
    @report = Report.new
  end

  def create
    authorize! :create, Report
  end

  def destroy
    @report = Report.find(params[:id])
    authorize! :destroy, @report
    @report.destroy
    respond_to do |format|
      format.html
      format.js { render :json => nil, :status => :ok}
    end
  end

end
