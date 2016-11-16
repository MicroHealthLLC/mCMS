require 'rails_helper'

RSpec.describe "appointments/show", type: :view do
  before(:each) do
    @appointment = assign(:appointment, Appointment.create!(
      :title => "Title",
      :description => "MyText",
      :appointment_type_id => 2,
      :appointment_status_id => 3,
      :user_id => 4,
      :with_who_id => 5,
      :with_who_type => "With Who Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/With Who Type/)
  end
end
