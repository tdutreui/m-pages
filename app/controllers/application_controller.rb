class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    private

    def current_user_session
	return @current_user_session if defined?(@current_user_session)
	@current_user_session = UserSession.find
    end

    def current_user
	return @current_user if defined?(@current_user)
	@current_user = current_user_session && current_user_session.user
    end

    def current_user_guest?
	current_user && current_user.email.include?("morningpages.ink")
    end

    def alert_if_guest
	if current_user_guest?
	    flash[:info]="Enjoying this website? Consider #{(view_context.link_to "signing up", new_user_path, class: "alert-link").html_safe } (your pages will be kept)".html_safe
	end
    end

    helper_method :current_user_session, :current_user, :current_user_guest?, :alert_is_guest
end
