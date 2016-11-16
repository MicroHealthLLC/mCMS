require 'rails_helper'

RSpec.describe "appointments/new", type: :view do
  before(:each) do
    assign(:appointment, Appointment.new(
      :title => "MyString",
      :description => "MyText",
      :appointment_type_id => 1,
      :appointment_status_id => 1,
      :user_id => 1,
      :with_who_id => 1,
      :with_who_type => "MyString"
    ))
  end

  it "renders new appointment form" do
    render

    assert_select "form[action=?][method=?]", appointments_path, "post" do

      assert_select "input#appointment_title[name=?]", "appointment[title]"

      assert_select "textarea#appointment_description[name=?]", "appointment[description]"

      assert_select "input#appointment_appointment_type_id[name=?]", "appointment[appointment_type_id]"

      assert_select "input#appointment_appointment_status_id[name=?]", "appointment[appointment_status_id]"

      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"

      assert_select "input#appointment_with_who_id[name=?]", "appointment[with_who_id]"

      assert_select "input#appointment_with_who_type[name=?]", "appointment[with_who_type]"
    end
  end
end
