class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index about ]
  before_action :resume_session, only: [ :index ]

  def index
  end

  def about
  end
end
