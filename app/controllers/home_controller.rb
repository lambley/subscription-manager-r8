class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
  before_action :resume_session, only: [ :index ]

  def index
    flash[:notice] = "This is a test flash message."
  end
end
