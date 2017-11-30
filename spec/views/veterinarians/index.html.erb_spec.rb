require 'rails_helper'

RSpec.describe "veterinarians/index", type: :view do
  before(:each) do
    assign(:veterinarians, [
      Veterinarian.create!(
        :full_name => "Full Name",
        :phone => "Phone",
        :email => "Email"
      ),
      Veterinarian.create!(
        :full_name => "Full Name",
        :phone => "Phone",
        :email => "Email"
      )
    ])
  end

  it "renders a list of veterinarians" do
    render
    assert_select "tr>td", :text => "Full Name".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
