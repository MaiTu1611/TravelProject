class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to articles_path }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ redirect_to articles_path }
    end
  end

  private
  def after_confirmation_path_for(resource_name, resource)
    articles_path
  end
end