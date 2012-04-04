class ApplicationController < ActionController::Base
	USER, PASSWORD = "keymaster","theywon'tletmehaveamaster"
  protect_from_forgery
  before_filter :authentication_check

  private

  def authentication_check
	authenticate_or_request_with_http_basic do |user, password|
		user == USER && password == PASSWORD
	end
  end
end
