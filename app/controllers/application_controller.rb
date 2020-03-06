class ApplicationController < ActionController::API
  include Authenticable
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
   end
end
