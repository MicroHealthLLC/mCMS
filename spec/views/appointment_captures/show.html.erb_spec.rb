require 'rails_helper'

RSpec.describe "appointment_captures/show", type: :view do
  before(:each) do
    @appointment_capture = assign(:appointment_capture, AppointmentCapture.create!(
      :user_id => 2,
      :appointment_id => 3,
      :assessment_id => 4,
      :disposition_id => 5,
      :procedure_id => 6,
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/MyText/)
  end
end
