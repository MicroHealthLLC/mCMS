require 'rails_helper'

RSpec.describe "appointment_captures/index", type: :view do
  before(:each) do
    assign(:appointment_captures, [
      AppointmentCapture.create!(
        :user_id => 2,
        :appointment_id => 3,
        :assessment_id => 4,
        :disposition_id => 5,
        :procedure_id => 6,
        :note => "MyText"
      ),
      AppointmentCapture.create!(
        :user_id => 2,
        :appointment_id => 3,
        :assessment_id => 4,
        :disposition_id => 5,
        :procedure_id => 6,
        :note => "MyText"
      )
    ])
  end

  it "renders a list of appointment_captures" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
