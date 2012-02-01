class HomeController < ActionController::Base

  layout 'home'

  def index
  end

  def about
    @studies = Study.select([:id,:code,:name])
    render :layout => 'application'
  end

  def acoustic_telemetry
    render :layout => 'application'
  end

  def have_data
    render :layout => 'application'
  end

end
