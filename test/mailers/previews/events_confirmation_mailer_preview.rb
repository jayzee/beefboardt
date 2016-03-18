# Preview all emails at http://localhost:3000/rails/mailers/events_confirmation_mailer
class EventsConfirmationMailerPreview < ActionMailer::Preview
 def confirmation_email
    EventsConfirmationMailer.confirmation_email(Event.first.host.user, Event.first)
  end
end
