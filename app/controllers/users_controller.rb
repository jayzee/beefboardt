class UsersController < ApplicationController


  def attend
    #binding.pry
    # add user to attendee
    @attendee = Attendee.create(event_id: params[:event_id], user_id: params[:user_id])

    @event = Event.find(params[:event_id])
    @user = current_user
    redirect_to event_path
    #render 'events#show'
  end

end
