class UsersController < ApplicationController

  layout  'admin'

  def index
    authorize! :manage, @user
    respond_to do |format|
      format.html
      format.dataTable {
        columns = params[:sColumns].split(",")
        sort_direction = params[:sSortDir_0]
        sort_column = columns[params[:iSortCol_0].to_i].to_s
        page_num = (params[:iDisplayStart].to_i / params[:iDisplayLength].to_i) + 1

        users = User.order("#{sort_column} #{sort_direction}").page(page_num.to_i).per(params[:iDisplayLength].to_i)
        render :json => {
          :sEcho => params[:sEcho],
          :iTotalRecords => users.total_count,
          :iTotalDisplayRecords => users.total_count,
          :aaData => users.as_json({
            :methods => [:DT_RowId, :confirmed?],
            :only => [:name, :email, :organization, :requested_role, :role, :approved, :newsletter]
          })
        }
      }
    end
  end

  def newsletter
    authorize! :manage, @user
    respond_to do |format|
      format.json {
        columns = params[:sColumns].split(",")
        sort_direction = params[:sSortDir_0]
        sort_column = columns[params[:iSortCol_0].to_i].to_s
        users = User.where({:newsletter => true}).order("#{sort_column} #{sort_direction}")
        render :json => {
          :sEcho => params[:sEcho],
          :aaData => users.as_json({
            :methods => [:DT_RowId],
            :only => [:name, :email, :newsletter]
          })
        }
      }
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.html
      format.js { render :json => nil, :status => :ok}
    end
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    status = @user.update_attributes(params[:user]) ? 200 : 500
    respond_to do |format|
      format.js { render :json => nil, :status => status}
    end
  end
end
