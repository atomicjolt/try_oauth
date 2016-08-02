class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorized?
    session.key?(:auth_hash)
  end

  def authorize!
    redirect_to "/auth/canvas" unless authorized?
  end

end
