class ApplicationController < ActionController::Base
  helper_method :current_user
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

  end

  def required_user
    redirect_to '/login' unless current_user
  end

  private

    def render_403
      render file: "public/403.html", status: 403
    end

    def render_404
      render file: "public/404.html", status: 404
    end

    def check_if_admin
      render_403 unless params[:admin]
    end




end
