# require_dependency "event_calendar/application_controller"

module EventCalendar
  class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    def index
      date = params[:start_date] ? Date.strptime(params[:start_date]) : Date.today
      @events = Event.
          where('( start_time >= :start_date AND start_time <= :end_date) OR ( start_time <= :end_date AND end_time >= :start_date)',
                start_date: date.beginning_of_month,
                end_date: date.end_of_month
          )
    end

    # GET /events/1
    def show
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /events/1
    def destroy
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(Event.safe_attributes)
      end
  end
end
