class ExploreController < ApplicationController

  def index
    @maxZoomLevel = (can? :manage, Deployment) ? 20 : 10
  end

end
