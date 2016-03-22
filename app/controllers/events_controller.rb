class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :home]

  def home
    @events = Event.top_six
  end

  def attend
    attendee = set_attendee
    @event = set_event
    original_status = @event.confirmed
    @event.check_confirm_status
    if original_status != @event.confirmed
      EventsConfirmationMailer.confirmation_email(@event.host.user, @event).deliver
    end
    redirect_to event_path(@event)
  end

  def unattend
   event_id = params[:id]
   attendee = Attendee.find_by(user_id: current_user.id, event_id: event_id)
   attendee.destroy
   event = set_event
   event.check_confirm_status
   redirect_to event_path(event_id)
  end

  def index
    if params.has_key?(:tags)
      @events = Event.upcoming.filter_by_tags(params[:tags])
    elsif params.has_key?(:query)
      @events = Event.upcoming.search(params[:query])
      unless @events.present?
        flash.now[:notice] = "No beef here. #{params[:query]} didn't match any of our events. Try again!"
      end
    else
      @events = Event.upcoming
    end
  end

  def new
    @name = params[:name]
    @event = Event.new
    @event.tags.build
  end

  def create
    @event = Event.new(event_params)
    @event.build_host(user_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def show
    @event = set_event
  end

  def edit
    @event = set_event
  end

  def update
    @event = set_event
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end

  def destroy
    event = set_event
    event.destroy
    redirect_to root_path
  end

  def analytics
    @tags = Tag.all
    @events = Event.all
    @attendees = Attendee.all
  end

  private

    def event_params
      params.require(:event).permit(:name,:location,:description,:event_time,:signup_deadline,:cost_per_person,:flat_cost,:minimum_attendees,tag_ids:[], tags_attributes: [:name])
    end

    def user_params
      params.require(:event).permit(:user_id)
    end

    def set_event
      Event.find(params[:id])
    end

    def set_attendee
      Attendee.create(user_id:current_user.id, event_id:params[:id])
    end

end
