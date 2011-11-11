class SearchController < ApplicationController

  def index

  end

  def tags
    render :json => (Tag.search_all(params[:text]) + TagDeployment.includes(:tag).search_all(params[:text]).map(&:tag)).uniq.as_json
  end

  def reports
    render :json => Report.search_all(params[:text]).as_json
  end

end
