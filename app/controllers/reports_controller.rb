class ReportsController < ApplicationController

  layout 'application'

  def index
    authorize! :manage, Report
  end

  def new
    authorize! :create, Report
    @report = Report.new
  end

end
