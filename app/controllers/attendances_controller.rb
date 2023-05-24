class AttendancesController < ApplicationController
  include AttendancesHelper

  before_action :set_attendance, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @attendances = Attendance.all
  end

  def show
  end

  def new
    @attendance = Attendance.new
  end

  def edit
  end

  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(event_id: @event.id, user_id: current_user.id)

    if @attendance.save
      redirect_to event_path(@event.id), notice: "You are registered!"
    else 
      render :new
    end
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance.destroy!
    redirect_to attendances_url, notice: "Attendance was successfully destroyed."
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:stripe_customer_id, :event_id, :user_id, :stripe_checkout_session_id)
  end
end
