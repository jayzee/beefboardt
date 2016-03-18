require 'test_helper'
 
class EventControllerTest < ActionDispatch::IntegrationTest
  test "confirm event" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post attend_event_path, params: { user_id: 2 }
    end
    confirm_event = ActionMailer::Base.deliveries.last
 
    assert_equal "Go for <%= @event.email %>", invite_email.subject
    assert_equal 'gmoseson@gmail.com', invite_email.to[0]
    assert_match(/Hi there./, invite_email.body.to_s)
  end
end