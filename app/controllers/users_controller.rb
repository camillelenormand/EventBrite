class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :is_user?, only: %i[ edit update ]
  before_action :is_admin?, only: %i[ edit update destroy ]

  def index
    @users = User.all
  end

  def show
    @events = Event.where(admin_id: @user.id).order(:start_date)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "Your profile has been updated."
    else
      render :edit  
    end
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:description,:email, :avatar, :password, :stripe_customer_id)
  end

  def is_user?
    set_user
    unless current_user == @user
      flash[:danger] = "You can't view this profile."
      redirect_to root_path
    end
  end

  def is_admin?
    set_user
    unless current_user.admin?
      flash[:danger] = "You can't edit this profile."
      redirect_to root_path
    end
  end
end
