module EventsHelper

  def is_hosting(event)
    current_user && event.host.user == current_user
  end

  def is_attending(event)
    current_user && event.attendees.include?(current_user)
  end

end
