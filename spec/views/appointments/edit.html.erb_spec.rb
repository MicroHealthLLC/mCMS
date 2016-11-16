require 'rails_helper'

RSpec.describe "appointments/edit", type: :view do
  before(:each) do
    @appointment = assign(:appointment, Appointment.create!(
      :title => "MyString",
      :description => "MyText",
      :appointment_type_id => 1,
      :appointment_status_id => 1,
      :user_id => 1,
      :with_who_id => 1,
      :with_who_type => "MyString"
    ))
  end

  it "renders the edit appointment form" do
    render

    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do

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
