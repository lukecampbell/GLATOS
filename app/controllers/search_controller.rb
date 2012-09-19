class SearchController < ApplicationController

  layout 'search'

  def index

  end

  def tag
    authorize! :manage, Tag
  end

  def match_tags
    z_tags = params[:text].split(",").map(&:strip)
    tags = []
    tags << Tag.includes(:tag_deployments).includes(:study).exact_match(z_tags.join(" ")).all
    tags << TagDeployment.includes({:tag => :study}).exact_match(z_tags).map(&:tag)

    match_ids = z_tags.map{ |z| Tag.find_all_matches(z).all.map(&:id) }
    tags << Tag.includes(:tag_deployments).includes(:study).where(:id => match_ids).all

    # TODO: Do we need only return tags the user can manage?
    # tags.select! { |t| can? :manage, t }
    render :json => tags.flatten.compact.uniq.as_json({
                      :only => [:id, :code, :code_space, :model],
                      :methods => [:active_deployment_json],
                      :include =>
                        {
                          :study => {
                            :only => [:id, :name],
                            :include => {:user => {
                              :only => [:name, :email]
                            }}
                          },
                        }
                      })
  end

  def tags
    tags = Tag.includes(:study).search_all(params[:text])
    deps = TagDeployment.includes({:tag => :study}).search_all(params[:text]).map(&:tag)
    tags = (tags + deps).select { |t| can? :manage, t }
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
