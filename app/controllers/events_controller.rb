class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin?, only: [:edit, :update, :destroy]
  before_action :is_validated?, only: [:show, :create]

  # GET /events or /events.json
  def index
    @events = Event.where(validated: true)
  end

  # GET /events/1 or /events/1.json
  def show
    @attendances = Attendance.where(event_id: @event.id)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def is_admin?
    unless current_user == @event.admin_id
      redirect_to event_path(@event.id), notice: "You can't edit this event."
    end
  end

  def is_validated?
    if params[:id]
      @event = Event.find(params[:id])
      redirect_to root_path, notice: "This event is not validated yet." unless @event.validated
    end
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :description, :start_date, :location, :price, :duration, :admin_id, :event_picture, :validated)
  end
end
