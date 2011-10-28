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

end
