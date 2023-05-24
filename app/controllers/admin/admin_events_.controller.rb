class Admin::AdminEventsController < ApplicationController
  before_action :authenticate_user!, :authorize_admin!

  def index
    @events = Event.where(validated: nil)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create 
    @event = Event.new(event_params)
    if @user.save
      redirect_to admin_root_path, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to admin_root_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      redirect_to admin_root_path, notice: "User was successfully deleted."
    else
      render :index
    end
  end

  def validate_event
    @event.update(validated: true)
    redirect_to admin_root, notice: "Event was successfully validated."
  end

  def reject_event
    @event.update(validated: false)
    redirect_to admin_root, notice: "Event was successfully rejected."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private 

  def authorize_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end

end
