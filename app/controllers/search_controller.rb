class SearchController < ApplicationController

  def index

  end

  def tags
    tags = Tag.includes(:study).search_all(params[:text])
    deps = TagDeployment.includes({:tag => :study}).search_all(params[:text]).map(&:tag)
    tags = (tags + deps).uniq
    render :json => tags.as_json({
                      :only => [:id, :code, :code_space],
                      :include => {:study => {
                        :only => [:id, :name]
                      }}
                    })
  end

  def reports
    reports = Report.includes({:tag_deployment => {:tag => :study}}).search_all(params[:text])
    render :json => reports.as_json({
                      :include => { :tag_deployment => {
                        :only => [nil],
                        :include => {:tag => {
                            :only => [:id,:code],
                            :include => {:study => {
                              :only => [:id, :name]
                            }}
                          }
                        }
                      }}
                    })
  end

  def studies
    studies = Study.search_all(params[:text])
    render :json => studies.as_json({

    })
  end

  def deployments
    deps = Deployment.includes(:study, :otn_array).search_all(params[:text])
    render :json => deps.as_json({
                      :only => [:id, :start, :ending, :seasonal, :model],
                      :methods => [:code],
                      :include => {
                        :study => { :only => [:id, :name] },
                        :otn_array => { :only => :name }
                      }
                    })
  end

end
