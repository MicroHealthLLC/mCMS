require 'rails_helper'

RSpec.describe "appointments/index", type: :view do
  before(:each) do
    assign(:appointments, [
      Appointment.create!(
        :title => "Title",
        :description => "MyText",
        :appointment_type_id => 2,
        :appointment_status_id => 3,
        :user_id => 4,
        :with_who_id => 5,
        :with_who_type => "With Who Type"
      ),
      Appointment.create!(
        :title => "Title",
        :description => "MyText",
        :appointment_type_id => 2,
        :appointment_status_id => 3,
        :user_id => 4,
        :with_who_id => 5,
        :with_who_type => "With Who Type"
      )
    ])
  end

  it "renders a list of appointments" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "With Who Type".to_s, :count => 2
  end
end
