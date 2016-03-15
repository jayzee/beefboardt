class EventsController < ApplicationController
  def home
    @events = Event.all
  end

  def new
    @name = params[:name]
    @event = Event.new
  end

  def create
    event = Event.new(event_params)
    event.build_host(user_params)
    if event.save
      redirect_to event_path(event)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def event_params
    params.require(:event).permit(:name,:location,:description,:event_time,:signup_deadline,:cost_per_person,:flat_cost,:minimum_attendees,tag_ids:[])
  end

  def user_params
    params.require(:event).permit(:user_id)
  end

end
