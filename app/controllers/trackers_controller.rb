class TrackersController < ApplicationController

  def show
    tracker_api = TrackerAPI.new
    @tracker_stories = tracker_api.stories(current_user.token, params[:id] )
    @project_name = params[:name]
  end


end
