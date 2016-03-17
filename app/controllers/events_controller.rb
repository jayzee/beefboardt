class EventsController < ApplicationController

    def attend
     # add user to attendee

     if params[:user_id]
         @attendee = Attendee.create(event_id: params[:id], user_id: params[:user_id])

         @event = Event.find(params[:id])
         @user = current_user
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

    # needed for _event form
    @user = current_user
  end

  def create
    event = Event.new(event_params)
    event.build_host(user_params)
    if event.valid?
      event.save
      redirect_to event_path(event)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    # puts nil if the user is not logged in
    @user = current_user

  end

  def edit
    @event = Event.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private

  def event_params
    params.require(:event).permit(:name,:location,:description,:event_time,:signup_deadline,:cost_per_person,:flat_cost,:minimum_attendees,tag_ids:[], tags_attributes: [:name])
  end

  def user_params
    params.require(:event).permit(:user_id)
  end

end
