class SubmissionsController < ApplicationController

  def index
    authorize! :manage, Submission
    respond_to do |format|
      format.html { render :layout => 'admin' }
      format.dataTable {
        columns = params[:sColumns].split(",")
        sort_direction = params[:sSortDir_0]
        sort_column = columns[params[:iSortCol_0].to_i].to_s
        page_num = (params[:iDisplayStart].to_i / params[:iDisplayLength].to_i) + 1

        submissions = Submission.includes(:user).order("#{sort_column} #{sort_direction}").page(page_num.to_i).per(params[:iDisplayLength].to_i)
        render :json => {
          :sEcho => params[:sEcho],
          :iTotalRecords => submissions.total_count,
          :iTotalDisplayRecords => submissions.total_count,
          :aaData => submissions.as_json({
            :methods => [:DT_RowId, :zipfile_url],
            :only => [:status],
            :include => {:user => {
                          :only => [:name, :email]
                        }}
          })
        }
      }
    end
  end

  def new
    authorize! :create, Submission
    @submission = Submission.new
  end

  def create
    authorize! :create, Submission
    @submission = Submission.new( params[:submission] )
    @submission.user = current_user
    @submission.status = "New"
    if @submission.save
      redirect_to submission_path(@submission), :notice => "Submission was successfully uploaded"
    else
      render :action => :new
    end
  end

  def show
    @submission = Submission.includes(:user).find(params[:id])
    authorize! :read, @submission
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @submission = Submission.find(params[:id])
    authorize! :destroy, @submission
    @submission.destroy
    respond_to do |format|
      format.html
      format.js { render :json => nil, :status => :ok}
    end
  end

  def analyze
    @submission = Submission.find(params[:id])
    authorize! :manage, @submission
    respond_to do |format|
      format.html
    end
  end

  def parse
    @submission = Submission.find(params[:id])
    authorize! :manage, @submission
    csvfiles = @submission.csvfiles
    # OTN_ARRAY
    otns, errors = OtnArray.load_data(csvfiles.grep(/location/i).first)
    otns.map(&:save)
    respond_to do |format|
      format.js { render :json => {:errors => errors, :number => otns.size} }
    end
  end

  def deployments
    @submission = Submission.find(params[:id])
    authorize! :manage, @submission
    # DEPLOYMENTS
    csvfiles = @submission.csvfiles
    deps,errors = Deployment.load_data(csvfiles.grep(/deployment/i).first)
    deps.each(&:save)
    respond_to do |format|
      format.js { render :json => {:errors => errors, :number => deps.size} }
    end
  end

  def proposed
    @submission = Submission.find(params[:id])
    authorize! :manage, @submission
    # PROPOSED DEPLOYMENTS
    csvfiles = @submission.csvfiles
    props,errors = Deployment.load_proposed_data(csvfiles.grep(/deployment/i).first)
    props.each(&:save)
    respond_to do |format|
      format.js { render :json => {:errors => errors, :number => props.size} }
    end
  end

  def retrievals
    @submission = Submission.find(params[:id])
    authorize! :manage, @submission
    # RETRIEVALS
    csvfiles = @submission.csvfiles
    rets,errors = Retrieval.load_data(csvfiles.grep(/recover/i).first)
    rets.each(&:save)
    respond_to do |format|
      format.js { render :json => {:errors => errors, :number => rets.size} }
    end
  end

  def tags
    @submission = Submission.find(params[:id])
    authorize! :manage, @submission
    # TAGS
    csvfiles = @submission.csvfiles
    tags,tagerrors = Tag.load_data(csvfiles.grep(/tagging/i).first)
    tags.each(&:save)

    # TAG DEPLOYMENTS
    tagdeps,tagdeperrors = Tag.load_tag_deployments(csvfiles.grep(/tagging/i).first)
    tagdeps.each(&:save)

    errors = tagerrors + tagdeperrors
    respond_to do |format|
      format.js { render :json => {:errors => errors, :number => tags.size} }
    end
  end

end
