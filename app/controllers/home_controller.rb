class HomeController < ActionController::Base

  layout 'home'

  def index
  end

  def about
    @studies = Study.select([:id,:code,:name]).select do |s|
      s.active || (authorize! :update, s rescue false)
    end
    render :layout => 'application'
  end

  def acoustic_telemetry
    render :layout => 'application'
  end

  def have_data
    render :layout => 'application'
  end

end
