class UsersController < ApplicationController

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name,:phone])
  # end

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
