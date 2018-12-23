class ApplicationController < ActionController::Base
  helper ApplicationHelper
  config.mailer_sender = ENV['MAILER_USER']
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|      
    render :file => 'public/500.html', :status => :denied, :layout => false
  end

  # rescue_from Exception do |exception|
  #   respond_to do |format|
  #     format.html { render :file => "errors/internal_server_error", 
  #       :layout => false, 
  #       :status => :internal_server_error, 
  #       :locals => {:exception => exception}}
  #   end
  # end

  def catch_404
    respond_to do |format|
      format.html { render :file => "errors/page_not_found", 
        :layout => false, 
        :status => :not_found, 
        :locals => {:exception => params[:path]}}
    end
  end

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_cache_buster

    def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

    protected
      def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name,:roles_mask, :email, :telephone,:password, :password_confirmation, roles: []])
          devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :password_confirmation])
      end

       # Redirect to articles_path when login success
      # def after_sign_in_path_for(resource)
      #   @user.save_role
      #   if @user.has_role?
      #       byebug
      #       request.env['omniauth.origin'] || stored_location_for(resource) || articles_path
      #     else
      #       byebug
      #       questions_path
      #     end
      # end

      # Redirect to articles_path when login success
      # def after_sign_up_path_for(resource)
      #   byebug
      #   @user.save_role
      #   if @user.has_role?
      #       byebug
      #       request.env['omniauth.origin'] || stored_location_for(resource) || articles_path
      #     else
      #       byebug
      #       questions_path
      #     end
      # end
end
