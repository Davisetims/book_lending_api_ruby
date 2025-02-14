class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  layout "application" # Ensure Devise uses the correct layout
end
