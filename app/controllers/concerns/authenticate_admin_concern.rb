module AuthenticateAdminConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_admin
  end

  def authenticate_admin
    unless current_user && current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end