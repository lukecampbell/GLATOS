class UsersController < ApplicationController

  layout  'admin'

  def index
    authorize! :manage, @user
    respond_to do |format|
      format.html
      format.json {
        columns = params[:sColumns].split(",")
        sort_direction = params[:sSortDir_0]
        sort_column = columns[params[:iSortingCols].to_i]
        page_num = (params[:iDisplayStart].to_i / params[:iDisplayLength].to_i) + 1

        users = User.order("#{sort_column} #{sort_direction}").page(page_num.to_i).per(params[:iDisplayLength].to_i)
        render :json => {
          :sEcho => params[:sEcho],
          :iTotalRecords => users.total_count,
          :iTotalDisplayRecords => users.total_count,
          :aaData => users.as_json({
            :methods => [:DT_RowId],
            :only => [:name, :email, :role, :approved]
          })
        }
      }
    end
  end

  def destroy
    authorize! :destroy, @user
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html
      format.js { render :json => nil, :status => :ok}
    end
  end

  def update
    authorize! :update, @user
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    status = @user.update_attributes(params[:user]) ? 200 : 500
    respond_to do |format|
      format.js { render :json => nil, :status => status}
    end
  end
end
