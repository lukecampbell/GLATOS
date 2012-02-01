class HomeController < ActionController::Base

  layout 'home'

  def index
  end

  def about
    render :layout => 'application'
  end

  def acoustic_telemetry
    render :layout => 'application'
  end

  def have_data
    render :layout => 'application'
  end

end
