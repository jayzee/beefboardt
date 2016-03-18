class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :home]

  def attend
   if params[:user_id]
       @attendee = Attendee.create(event_id: params[:id], user_id: params[:user_id])
       @event = set_event
        if @event.attendee_count >= @event.minimum_attendees
          @event.confirmed = true
          @event.save
       end
       # @event.check_confirm_status
       redirect_to event_path(@event)

    else
      redirect_to sign_in_path
    end
  end

  def home
    @events = Event.all
  end

  def index
    if params.has_key?(:tags)
      @events = Event.filter_by_tags(params[:tags])
    elsif params.has_key?(:query)
      @events = Event.search(params[:query])
    else
      @events = Event.all
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
    if @event.valid?
      @event.save
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

end
