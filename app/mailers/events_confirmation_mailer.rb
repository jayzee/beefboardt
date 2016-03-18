class EventsConfirmationMailer < ApplicationMailer

  def confirmation_email(user, event)
    @user = user
    @event = event
    emails = @event.attendees.map {|attendee| attendee.email}
    mail(to: emails, subject: "#{@event.name} is a go!")
  end
end
